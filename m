Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F043EC807
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963708; cv=none; b=mDMBO7bTEgc0ciyyuC8IgMCA0D+Oo/SSJpzWYx8T/79+ak700ln/3rkOoUqSw5hNOPpQ0V40R4W6Yj7rD4SlIqZB5hgKV0FbnDcNro+l+XTRtjp1U86rYGJbj0oRp+1/4gDcMz34XbXBxuwsUvGo0U8XTxeAXrwx/iNcAovk/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963708; c=relaxed/simple;
	bh=QNQGAQMvi98odGpNTyWdFaTAXKFmq6Y70G0q+N0VGr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ME5BuGsdqqWiZ8U50fjYgR6Q27L176o8tPFoxYowoj7gIUE6/s6dqw/MnNyJlbgeABRrXuPtjtBkG2C6E7vU0FhtVIMxDM7j/lC/5aL9CBfRTqbxPQbk/Nc+LBd7+qqk18tK17oESN4apoOUzYNx1JJahtUOyRiqlDfhFFv2rF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh8ZJT2A; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh8ZJT2A"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c68f1e863so931901fa.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963703; x=1787568503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tufsylix9QRWdBSzfeQ8rMK41gi/ULWE3IKWJZ+mOhE=;
        b=bh8ZJT2AxW5xqd16OIIippJiBTQ+yzQBdLZ+ViYCzkLM6NZLofFRuV9Y+6ROjXLtMI
         arnhBG11bBiMUwMTdADiQZ+lHrpfLVzGGizN3jHmVgwdhHVEwAKoN0jtfNy2v+jJMsVe
         pwba4wXNAWvRz8/HmBH4ZoMN8QbTS31oO+EWA6l3nFOe1LbJ4X3TtIY38aZ+aE2GeBaX
         6RSNawW8fvSiYIJ7488FxYh62Eno8gPUJ2ufU0SSvEqZcRmQvi1d87aJfd/jyg/DJwek
         ldW6tOKIxc7B4kf7T4z+vxi1yhug9VRJp318QR4jk0/qB4xp10nNKIW1eoCP8oJpmzC8
         RhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963703; x=1787568503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tufsylix9QRWdBSzfeQ8rMK41gi/ULWE3IKWJZ+mOhE=;
        b=gmOg/Re64cm41DLT+0Eyos+lQhZauvcMK/1vEY0fxwC+mi51+yHKzmOet8b9vvdBkP
         1fh1h5klKI70vLPWYsEPr8vx959c+Ue0HqtFTvesHqELq/4T0ZpPCh9UaRFEMrz0KJNG
         trkhWJD/zw6OVSTsWFbQHY9nP1KBpSuGP/DXCr+5oulS54/d1IqBN9Dxir5PkEoMmuvw
         s9hzJD61BtAR3OUcd0TcpvJHu3knrdQm375aZ8pmhP9mqR7uiqJ4cjwo4P2C9CyaOCZk
         91a7gLz52xqralotRXgGw5i0lzJ6n3B9PAZb9Bb7k1gKle3AMxt1gAC8g+CGHGhq/lj2
         TV2A==
X-Gm-Message-State: AOJu0Yyx9SlsaEMInYVTDbgtS/uWjKS8KKC2dBTG2axEJ0zFm3wOX/by
	HP0xApioDwuF4p7B83WhyweYfOrUrVqi7Y9iy9JrPJ2erzACRN5doaJAHZBR4M2h
X-Gm-Gg: AR+sD12BjHn9FVjE1CJDi8XbkUR8AHNFD+xdTxm+T2BvM9uTKbAflPuwD7EXv74g4HO
	AEeRYcU7podBcGOJW8mG8gN9F4D8ykkrYX9kFNmSuYdc2HoBFqEMJvvnUqxXUcfpl9QCwMgEmS3
	uCdT2itl2kVkeQqUbuxbwrwzcfzhVnrYIghNr18nOgaxgp0wajsOXbssNEgl55S45rZ8s9p07D7
	iWA7yzwJPVunwd/3kl9BntM/Z/uFrxNsbdyuI46iwu7D3vlnlItljq6mpsPsdWuxrY2zzpjILsR
	L6aj0Gs/ybf8J93gokwEZt96A9A93PCKLj91O1BQ5AiP7UgHI+QjHE9aR754IYaXhdcbnXvkLqJ
	AS+umkG3Iqly+8FGbxNh+o3rMsONEq5goR/ZIeB+PDqdgTNZAugto4kfCIlc9jc4hCwAeR/Yw/k
	RXASwlaVrWQDZEdhjeymrgRAMjRuT3Lz1G3xEfuXsMZwlpdeN2wMNwPRQd3QYfLiuvvYLLSkDK9
	Sc=
X-Received: by 2002:a2e:b88a:0:b0:38d:fae9:9aa2 with SMTP id 38308e7fff4ca-3a1323d6060mr18125041fa.1.1786963702959;
        Mon, 17 Aug 2026 03:48:22 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0a1ee9sm3129031fa.8.2026.08.17.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:48:22 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1] btrfs: fix root leak if its reloc root is unexpected in merge_reloc_roots()
Date: Mon, 17 Aug 2026 13:48:12 +0300
Message-ID: <20260817104812.9200-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit ce6050bafb4e33377dc17fcc357736bfc351180c upstream.

If we have an unexpected reloc_root for our root, we jump to the out label
but never drop the reference we obtained for root, resulting in a leak.
Add a missing btrfs_put_root() call.

Fixes: 24213fa46c70 ("btrfs: do proper error handling in merge_reloc_roots")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 fs/btrfs/relocation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 43e8c331168e..d2a1323e8b10 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1956,6 +1956,7 @@ void merge_reloc_roots(struct reloc_control *rc)
 				 * corruption, e.g. bad reloc tree key offset.
 				 */
 				ret = -EINVAL;
+				btrfs_put_root(root);
 				goto out;
 			}
 			ret = merge_reloc_root(rc, root);
-- 
2.53.0

