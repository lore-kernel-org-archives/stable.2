Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411678;
	b=rlceEqLjJY1k+Hi0xKtuDi/Kgw8sJrFt5lf+FFQtx8TC0VILPlrXt69HK2w19R9iA4RW
	 ZaHbH/80a/6Oou0wIoybuxnINGpRdNEof5D+Q6in8yVwq6IfyDM5SMAzMBcqOjcXLyyVo
	 lGKLXzrvlB1bvEjncwFvYup0aCv70xMqUF57trX2fG4gsLh2THhiHPOEUWIrWxib3d4jD
	 JlpLKjcJ2SigmkIO48DvcWR37azfVDgRZtpwTNliqvghGJR/IKXIKC87g5X3V3IWq7coL
	 cCxeQZIbDKjxi7WTlygXoMN7xvb9P1coW8/4yoV2kuZ+bd8D/E81mLbKmjA02VUMNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ego8NFzf0UiBGElCelqndbspHpdeql7WuUYaP89/+j4=;
	b=aRDTg+AbyqIpIS2eRNBHnd+WlYtWkf3c7u/gcudm1260WigEe3nHJIjfQps4SNk2ciGB
	 oFNyIwUoGQs2BcdU4VisNevdTKzT+70g3SQ8MGzVm6O0h3e0rkTklg/hEMu2Sdpen/GiB
	 5UE1s/xEJ8n5mmbz/9EUk623AgFFjKRVJdbPDSHuSKAob41d05MhuBq9q0GB24PyLpWtu
	 QeSrrX/uGEqpGnLd/BBFS92hxHQrGehWOJLZqUsOWQmItUUQXmccZ5ExAbP6Io3vN9uPo
	 HeA/Ir+MJOQHmsIpZ9YrB4NFNNlkX8YEBkELfvv96hqfUzp+OD2qrhbGThsG4EHIWHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQlPwk+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5D606A88B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQlPwk+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7491F00A09;
	Wed, 11 Nov 2026 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411677;
	bh=Ego8NFzf0UiBGElCelqndbspHpdeql7WuUYaP89/+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQlPwk+PW5aCdRBp6lzFuOJF/6sfEQ24WKi1ABbTfH5HiIY72SYYCfqM1FER1/2wP
	 2V1dbL6i4432vRiBUlkyktzXdXNcMWkHhnQV+xfl9LWyBcQYb2e1YFqXYAUCvvK6FG
	 pFWvq4+j3OloBTj5YTi1qw1VzMlaLplXZswZgH9EO8L7mGnx0QfdDZfuoJFfEZSp2h
	 NfZV39SIJZUTW+9YpWD9xPkkooFIDRygfvcQg45SpNUF+U57tT34DIBkmwRZKXVQdz
	 AF8kbki5Cizkvb5+lvQXoEdAMFTdZAOTAb3p0V/MW0UdtzGIdCNemOTYmJaMWbSTEB
	 s593/a91zheHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seongjae Jeong <jsjlee1020@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] f2fs: fix submit accounting for IPU writeback
Date: Wed, 11 Nov 2026 10:41:13 -0500
Message-ID: <20261111154005.2482659-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154005.2482659-1-sashal@kernel.org>
References: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
 <20261111154005.2482659-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seongjae Jeong <jsjlee1020@gmail.com>

[ Upstream commit 6d1f622b9c069378cdb83088be2b15a9b480b8a3 ]

f2fs_write_cache_pages() uses the submitted count, which is set to
fio.submitted in f2fs_write_single_data_page(), to update nwritten
and decrement wbc->nr_to_write.

In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
However, in the IPU path, fio->submitted is never set and remains zero.
As a result, successful IPU writes are not accounted for.
This can cause asynchronous writeback to continue beyond its budget.

Set fio->submitted in f2fs_inplace_write_data() after a page is
successfully merged into a bio or submitted, so that successful
IPU writes are included in the writeback accounting.

Cc: stable@kernel.org
Fixes: d68f735b3bc9 ("f2fs: check io submission more precisely")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Adjusted context to preserve the older device-state and I/O-statistics calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fec3b4a9e9542..4d759917c2849 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3563,6 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err) {
+		fio->submitted = 1;
 		update_device_state(fio);
 		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 	}
-- 
2.53.0

