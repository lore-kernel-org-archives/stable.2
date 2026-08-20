Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6D3769F5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192351; cv=none; b=VI5ewerAq8CJ82Mm9Vs5sV3mEhdAet0rKJ1LrmglBtDF5LHzVvj+WVo/TtlDjB4beMxcOXYkuJ/ZBol6WqPOAS7HTtnGhjtJ/GzbXom7yC8N/FxNaS7Ysr/KagLlE1yyYU48q9/NtQ8COFGU8ZIEOk8LiwWaTFwNsp/PC/wp4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192351; c=relaxed/simple;
	bh=XJBm32FpixVa0XcZMETtH0JpwuBFU9LsnysDehf4Oyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuotCgDETW+YU8HMeTn+mggy5SkyeaYT0SZruX0hEalXqLJY31fvQFSUMb+RWg1qiTxMjNquFB8yrD0F7t7oA7jADQBegmsS+TjijRn58e4GBHGSvaghGPShRUO6kDJDpMWgFyOW9oMHtAkJKzBJ4gfVLmNc4IPFVr9OnJAojtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp2/yH4C; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp2/yH4C"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2683101a91.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192349; x=1787797149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XMfhi2zIy5MA4h9qyIvYKfFdy8VopSV3LiNkMMuhiY=;
        b=Vp2/yH4CdcSNaJPeznFk9dpUwDN+hrpS2JqGiE+bAt1j3Uuje0gRIJIrp9/lGqpkaD
         WMgUD3DmUhvTUUr+eWEm+JZ1uaSZMQSsEqB6JV0etbeuGfConrdO7zHVY6lmAAt7nIBE
         hAJnU+INDrpePEapaxzrh6Rj+91UlqS8VxfTjioMDUV7cF4lhq4ZS0KGKgMp6zxueqzc
         +trQdxmM7TWaMGtX1Unu13NXb9+bfKsEgrmu6RGhyfsQK+qf1l/8cOy49bHJUaKOHoB/
         7Xlx+cLKaiyPW894qUc/ILEAFXybx/3rj528a+0PHOnnT/X9CE/bKSw/G4ECas5uHHwt
         MH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192349; x=1787797149;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0XMfhi2zIy5MA4h9qyIvYKfFdy8VopSV3LiNkMMuhiY=;
        b=bR8lH5vbOChShkSm4iQjXGgtsGVcF9JHSf4CWWDy4udbCtTShorFTTuhuONH4FmII5
         LyMnQ/OZDuzNJsb0EZ+DgjV1etPIVX9uCH4iOWKstLZsC7b5cIwhTd7xbY3D7PLtuWEz
         F1UXfA6P0XGBR2vKOCUNhtwdG//ojRv0BH+GeCxH9OF9oXhXWZeVP9Vd1zWtPa5713aP
         ESEUU2W19iGYHaAw8srACL5Vdf+0kkNw2kDy8Pm2WRDcyHybfkJr91jVA7nIF79owgsy
         aWKTlCD5UrPnC+o+6Ko7SbVDS2UURxoAY5o+zmd9NttB57PGHd/XsORzh/khet6rY+5J
         T7Yw==
X-Forwarded-Encrypted: i=1; AHgh+RqS2HeuGtrcniqG4Qx+DFX5ZAhftH/X58YZ9tB+9NjAzO6Jz0cr/Na7a7sPaSqcnRiCYl2poUw=@vger.kernel.org
X-Gm-Message-State: AFuF++mg9YgM7gKhhCyM39haazqr3RynyaSjaT9My+3A9MWPLJBMCnUN
	hCEPA5kszrwvcWvsXI33mDBGBXzRlq/sgQ8uIYXaW8qfmK8IPJ4/cvt9
X-Gm-Gg: AR+sD12VV1B5hahFyywO5Fm9y/eri5P/lE/BCpQlMtt3GVvgtHtvRPyLoUSB8zwcZZM
	9TZcKGxUPoo9KgTttTwLfvaMYog+J0WkEeSjyf7xNWdCyc2P9dy2cHZbzPD/EN58FyGIdJoYJfB
	tbau/laoAfeksZQI0gax2xWB0sBO4WQmJeGeah9Z+Up5bjSmT281SOXJqzUeyPvqj3D5Q16236f
	3bqyxgN+j8hBHR36iV9Px5YxDF7Zdp8XLyDMJEcJjG5L033xdZk6Z75BPzET+3uJBaYzBHZ9Ubp
	gGBYm2B8BoSGd6ulvUvtX7Tw9aIs6Gox+BgV5oH/yOoW2qpaZAwywwkGa4NSlXgLUmuqE/JapBc
	lTC6s8oWFQbUftPTQSPhOmIloyanwpuZdMrs+FEb6YnvfFlAOJPtoaDixXUuGVgGtabUCbSsBdF
	eS94/BQZGQjEMjtdbMxlnwMQWhfmRvnOq33n0RqBSG+1BQkLGXNSijaH8hvDKmuqerzCE=
X-Received: by 2002:a17:90b:5684:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-39580f6b704mr17560895a91.11.1787192349538;
        Wed, 19 Aug 2026 19:19:09 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb17eb5sm5583412a91.3.2026.08.19.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:19:08 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Robert Morris <rtm@csail.mit.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: reject invalid empty mapping pairs
Date: Thu, 20 Aug 2026 11:18:51 +0900
Message-ID: <20260820-fix-empty-mp-v2-1-5d3367048b76@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=/0gbu5qp0hA9OXbiR9tuMBo3CmE1INmiWop12AnXC9E=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqhmLYqlj0vIA/9/pa9xxUymiafzMx5CMoNK/oK
 omKnf3h8RGJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaoZi2AAKCRA08jD6945I
 0x7+D/9cmQDp0FNxf4gV1c5diHRJ0I6Q+hhKvokPYgsIzzDjT7+4f55RMW/8f1WLbtbZaky4mGT
 aLehpuXLvq0+snbnp4X5qVI6t+nOeyQJr2orgAPmaKUD351HSkUH7v6Ri+jmIqpNNcXMhxvTDUD
 1RmH6yJ4Vt2Ks3eY8PQ5xL6aMlyV4FjzzSNbhUOsnKjGYkHOSbltGASspXcsCPYoaTC0B/l84FI
 WzbDbzrj4MHeFjG/iGDveIgYyZUcwktSlvNIGrgfpBzERKIw4D3qkO3j8krEAwOrEpTW6NEYe+A
 8Zaw2eM+a3aeQ4hAZFYdYeK6N/PxlHft/h19Bc6Tk9wc0ftRtn/jF404P4srIv6srvgSNbNjEdB
 NQ4JqpEWVsYfIGx6BiRnEfZBMPHSBdGGXCCY0rH8CFXHtTYdyJz4wK0PegsJwGvx8gmdBPjasfu
 lfCgrmLGyc1ILTx8YqCYMf9AOu5jHIO96kQ8B8KJEfn0p2Ix0NBUpXy3QrL8prnKfBpcwsuOdn8
 oWtz9FcpLPOPe8ZlwSJ+h2gMsiSShkwIebNYOZObRFr6pjxxodm8falfUQLnRvVIySsfHIFTtSY
 BOSnxf5OPzJyY7ngcgdSuywZHfXNRsxe9ET0fEqy7NJ5FsGvjQDOT9KNG0WYP+uQChY4ZYmOQrU
 k80BogXfl11l1ew==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp;
 fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: quoted-printable

Reject an attribute with empty mapping pairs if it has inconsistent=0D
highest VCN and size.=0D
=0D
Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")=
=0D
Reported-by: Robert Morris <rtm@csail.mit.edu>=0D
Closes: https://lore.kernel.org/all/9519.1786907182@localhost/=0D
Cc: stable@vger.kernel.org=0D
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>=0D
---=0D
Changes in v2:=0D
  * Restore reloading highest_vcn after mapping-pairs decoding.=0D
  * Add the validation of empty mapping-pairs to accept only=0D
    lowest_vcn =3D=3D 0 and highest_vcn =3D=3D -1.=0D
=0D
 fs/ntfs/runlist.c | 19 +++++++++++++++++++=0D
 1 file changed, 19 insertions(+)=0D
=0D
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c=0D
index 9eaadbc0ef47..00373e450ea7 100644=0D
--- a/fs/ntfs/runlist.c=0D
+++ b/fs/ntfs/runlist.c=0D
@@ -772,6 +772,25 @@ struct runlist_element *ntfs_mapping_pairs_decompress(=
const struct ntfs_volume *=0D
 		return ERR_PTR(-EIO);=0D
 	}=0D
 =0D
+	/*=0D
+	 * An empty mapping-pairs array is valid only for a zero-length=0D
+	 * attribute.=0D
+	 */=0D
+	if (!*buf &&=0D
+	    (vcn ||=0D
+	     le64_to_cpu(attr->data.non_resident.highest_vcn) !=3D=0D
+		     (u64)(vcn - 1) ||=0D
+	     le64_to_cpu(attr->data.non_resident.allocated_size) ||=0D
+	     le64_to_cpu(attr->data.non_resident.data_size) ||=0D
+	     le64_to_cpu(attr->data.non_resident.initialized_size))) {=0D
+		ntfs_error(vol->sb, "Invalid empty mapping pairs array.");=0D
+		return ERR_PTR(-EIO);=0D
+	}=0D
+	if (!vcn && !*buf && old_runlist && old_runlist->rl) {=0D
+		*new_rl_count =3D old_runlist->count;=0D
+		return old_runlist->rl;=0D
+	}=0D
+=0D
 	/* Current position in runlist array. */=0D
 	rlpos =3D 0;=0D
 	/* Allocate first page and set current runlist size to one page. */=0D
=0D
---=0D
base-commit: df7dce2090342170b7643d36f694204cae7792a9=0D
change-id: 20260819-fix-empty-mp-3f32eb769112=0D
=0D
Best regards,=0D
-- =0D
Thanks,=0D
Hyunchul=0D
=0D
