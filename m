Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408177;
	b=n1zBLRvj2bOu1IPJ+ZJkwYXeoaTOD/uNOCNDZVhgVwpaqhZNu5mWbVFqq5b9Q5n0L8XN
	 xsrROyjfnHndGOjH6Vm1cHVnJDJCJZxtrNZm5weQeVmSzWApOA3AIRxiA1hWNTVsbv17I
	 NkGxO39+bGeZIsh/4T7zsC+TbEksYf+ltJiPFwcGk8uXPKhHm7CxVJZ4Ls/1ZCd6pjSP8
	 i+jED46r8+p6iw2vYQrbPNEYHEBTQfmMt0xiBcN+sfcpKMjqbnJmCZrSbUPZCmEbfdtz9
	 CSqERS2Nn+UwvVWlwD8T3bncE+EV56DPF08D6canvJMfMzZDHIs/cJmP+wFzhgHSZOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=eofb4rt//CPwrsXnyaQEibO9rgJnVVcYMlLVW1+iWbw=;
	b=Bz/puYTtOMAgdX5DN3m+uw+VHLsGw/dtb2eKaO/pI8sZq8cJgDwWIFlZQaHYNJ/qIZZO
	 S86y7sWNYOqxHKlf5ZPduGiwDkksJK+Ai8kvkXDxf5ODj+LhvWWw8hL2qX36HQYdCdZY2
	 pPlU44DQBEF6ZOQMMJwZKBsAj7ueQEKc+pjdHe1dPaXU+tpp13vFlCmMaAaSghCCYHkpE
	 wikIltRxeI7nSNBg09E46L3Q/OGXGuvXBvHV99JEv55l3HZ5VnZy8J3igGbHH5U31ML1Q
	 JLvTM9Sjnwad9ZEJJCeStLSEuAxIx9syPoPok56mfwq5xulXsiLsOM9kxq3BveQoS6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=caLjPQaC;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60018606A89B;
	Wed, 11 Nov 2026 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60018606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=caLjPQaC
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jPmTM1l34z4xPSJ;
	Wed, 11 Nov 2026 22:42:47 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408167;
	bh=TtW33jKya7yf+pIUAp6NxKrTz7rbR+eAywMN6yjOfLc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=caLjPQaC9uVHp6phKWlY2a2p2VxatWLEpBOT6ZJrHEKosCsF/OlvgUOOr04hkhEQ4
	 SHJmQeh7a6zCTOPF2B2+fkFXX0aKrCvweJdRU67X48vykmx7g+bGjEEwrTI8vpOgBh
	 zc8PUqOg7YUU0frMASA/J8gxjZcYpbShoOeiGGyh9j5qm2WZDkXLZCc3N6HQ+gJR1K
	 /cybsQxozOi4Uc0FCmkUm32DAqb6CRGJNsGEMsfzEgh9SuqEAeUI3OA4iEAR1dR7jU
	 06fsHSCtupHO2QL0zfRDtsN6CHKsM2INgmtsXM6l0f+7ppuO+FHzJ3TSTKBUSmKpey
	 uYifJ6Yg5r1yQ==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ABEgiEQ094719;
	Wed, 11 Nov 2026 22:42:44 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:42:45 +0800 (CST)
X-Zmail-TransId: 2afa6af47ee5690-7a562
X-Mailer: Zmail v1.0
Message-ID: <20261111224245786kBVGPR0wSFFqHjmtHwtAJ@zte.com.cn>
In-Reply-To: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn
Date: Wed, 11 Nov 2026 22:42:45 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IGhhbmRsZSBzaG9ydCByZWFkcyBhbmQgd3JpdGVzIGluIHRoZSBmaWxlIGJhY2tlbmQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEgiEQ094719
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:42:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EE7.000/4jPmTM1l34z4xPSJ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When the file backend falls back to its bvec mempool, large requests
are submitted in synchronous chunks.  A short completion advances the
file position by the full chunk length and is eventually overwritten
with the total request length.  The target reports success for an
incomplete write or returns unread buffer contents as valid data.

The common completion path has another short-I/O case: a zero-byte
return, such as a read at EOF after the backing file is truncated, is
passed to errno_to_nvme_status() and becomes success.

Stop at any incomplete chunk and convert nonnegative short completions
to -EIO in both paths.  Preserve negative errors and full completions.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

Tested on 7.3.0-next-20261030 (QEMU/TCG) with the loop transport and a
file-backed namespace on tmpfs (buffered_io=1).

The chunked path is only taken when the bio_vec allocation falls back
to the mempool, so failslab was used to fail that allocation, limited to
nvmet_file_execute_rw() with the stack-trace filter (times=1,
ignore-gfp-wait=N).  The short completion was made deterministic by
shrinking the backing file behind nvmet's back (ns->size is only
revalidated on enable) and by leaving only 4 KiB of space in the tmpfs
for the last 64 KiB chunk of a 128 KiB write.  The values below are the
status words returned by NVME_IOCTL_IO_CMD:

                              unpatched    patched
  read  512 KiB               ret=0        ret=24582 (0x6006)
  read  256 KiB               ret=0        ret=24582
  read  128 KiB               ret=0        ret=24582
  write 128 KiB               ret=0        ret=24582

0x6006 contains NVME_SC_INTERNAL plus the Do Not Retry and More bits;
the More bit records the associated error-log entry.
Without the patch the reads report success although the tail of the
host buffer still holds the 0x5a pattern, and the write reports success
although only 68 KiB of 128 KiB reached the file.  Controls: without the
injection the short read already fails with 0x6006 on both kernels
(non-chunked path), and with the injection but a full-length read both
return 0.
  drivers/nvme/target/io-cmd-file.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..e95ab1f08cff 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -113,7 +113,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 	}
 
 	if (unlikely(ret != req->transfer_len))
-		status = errno_to_nvme_status(req, ret);
+		status = errno_to_nvme_status(req, ret < 0 ? ret : -EIO);
 	nvmet_req_complete(req, status);
 }
 
@@ -150,8 +150,11 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		if (unlikely(is_sync) &&
 		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
 			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
-			if (ret < 0)
+			if (ret != len) {
+				if (ret >= 0)
+					ret = -EIO;
 				goto complete;
+			}
 
 			pos += len;
 			bv_cnt = 0;
