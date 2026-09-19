Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9525B090
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796980; cv=none; b=S4OOQMCYPu75l0giA1tSPmZ/kzq3yfyfh58OP/zIm19wmWWGp0Ha9lcC9Rx+f9ElzP3ZmBHWD7KCf4tJiAHEdyqIuMqgpV8fWoxqFqu7ifrF64Q/72jQ6YhixelYqw7n2t5QvfI46V97svhMka1z2pLlHHwCke9/lQx+IAKjOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796980; c=relaxed/simple;
	bh=5hn+3SJcyVzss4VqEdL8V/gP/CY6+lzWZiktJfntfiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M7ViRmVjjEvPX9xbnj1aYYUtM20AlcW8K7RBOCa8pqrJ5FISH4DZs/ldgubZjrhXfE8Qsxvb+Dr1RqGbB3plOf0Js1wFvhU9yN5oOl+1h1jVp9l1zvVnBnCxrECPI6VrHJAn0U/ce10CRXQEVRHC8AK9l/RWOejsdUXTvGCnNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zbksv44P; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbksv44P"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso12238695e9.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789796977; x=1790401777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Wub6FkkohSWYkw99iErrJH/ltfuxLago62PvO/LfjY=;
        b=Zbksv44PWIeHgU2qn7RhuglINHUCmP2LcDzRAJqf6esajMmp5Xhar89UyywNEEvxts
         Cvki4Ii6LpYkGkCeRTnSLsOHrN1GBnftPYwFJAg1Lu63eAjdPgjN051NaVVKMbPyiqY7
         Nqoiyj4E05nMa0DTGDLyt7WHMTK0z4UFmxVzsOhgw3mAkA0bub/pyR41BgJL7OIbNa2h
         tJM7T0dNzl0ytndaOJ+C0lJ7P/HL4vDPnQ1JmXH0Wy/BFU4L5W56KmrlMQ8wZD6GqajB
         v7yXHFffWvZgCyP/QEyDwUQr7ovHs2Hgn4tfsGcFg17jL74EeMOiohsHVTT+xPYCztpq
         QvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789796977; x=1790401777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Wub6FkkohSWYkw99iErrJH/ltfuxLago62PvO/LfjY=;
        b=YfYjlcb4bYiWSGwCeek5UWOjNqqSSC48XbyVuOKIKiVBv2xSPzWBvzd8iAF0GSfbqV
         Bz9wVm3UV9kGNINyJ5jhmlwgnfaimRMWKMiwwjYq0O6SssSjqmFj7gkEs43sYE5umYzW
         rh56477dFz23A9k6k+TYeZ6Cyr+GkfG6JYFWYjygBQiJcQRYLZeApnINFUtA/E8rb/yp
         W06sbbTPm2qFmilJLiURj6TvaGWt7wYu4ZcUiZ4ZgO+ypL0dr36Ogko+QuniZW1A/AF/
         PctKRZDQd4KM7D7UHMu7PSYyQ06fSXL8ZnEWB0BHfnmYGVu1J0nxkUCmXBZLtCytvKdb
         +vBw==
X-Forwarded-Encrypted: i=1; AKwUvBwX8BrmmSEqGhHJyHaLxfOh7Oc4F8H1eDaNVpv3+q5XMtXH1RWlQizfNfHIN/H5QLjyj1ttAyc=@vger.kernel.org
X-Gm-Message-State: AFuF++lnIS44DsqSS2qSjDz2UqJyng3bjsy6f5ZZfuAzYWMYEvyJefCB
	AZUEzRNBAodQ5iZYuWbXMYxcA/W6b8n75+PbfL1BONy4b+cyEb96Dxi9
X-Gm-Gg: AYBFou1UUJ+0qIKfTnlp1749cwiPiEzq+pUgoeKVSu2Vk10YzhBv//+qWwp4yU88CYO
	M3ALGAyGRkpWKngtu4JeoygCRriIlACEtvYvyChCRI3+f7SCjfLxd7ZV8wR7jV306/vkUDhDh5N
	Jr4vXA/m+KO8O9JRNax1LqjrBwGyFvYU+UTa4t4S8xRpmeWOVZN/MpKM1uBwEF80gwSbls+b6ty
	5o1n6sMiU5/KsLtJ3yLFwkJxfk7LoD180rYFTYZa6Qn61jtO0FjPHH104+EFLTNU7ahUVaxUXRX
	U8Q6kEvpkY0MLTWXQr3qFYh1/kC7WKAlvk4K2+tTnYf4o5KK2/IXfKGbSdsVKHtdItcXC9PETcj
	xiT9+wRoes4uG48wrVl1bguGwmyWD0Z2qO7rduzJENIFGr06LteKqBc9yD8zBU3HQxPIOAwU1/M
	exudCLdHr7IwnfwV4D2+XSv7ZlHxZSg4N2wdmzm/hjhcgEL1Glhy5MZ7mRD7TtBR4zMBE1FbaQV
	uyAtohzyvy0VurrHl8JWnlMyW1TCxbTwkKFcW6m1zryVqdDv/zQNSt2uHapE/L1UA+5TPVt7iJT
	mXItDWGQnQMqIVGTckY5SKhPIrKtu51SO4bSriZYwlmJJTGJ9gfuH8EjCHwrA24MnEpW85jMYZL
	/wDapQO+a2icddDA=
X-Received: by 2002:a05:600c:6097:b0:49e:7cd8:b269 with SMTP id 5b1f17b1804b1-49fc57411a5mr63793185e9.21.1789796976836;
        Fri, 18 Sep 2026 22:49:36 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd8bc15esm28001935e9.1.2026.09.18.22.49.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:49:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	Xin Zeng <xin.zeng@intel.com>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: qat - zero the VF migration state buffer on save
Date: Sat, 19 Sep 2026 07:49:34 +0200
Message-Id: <20260919054934.27322-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QAT VF migration state buffer is allocated with kmalloc(), while
qat_vf_save_state() exposes all state_size bytes to userspace. The state
manager writes only the serialized sections, leaving the unused tail
unchanged. The first save can therefore disclose stale heap contents,
and subsequent saves can disclose data left by an earlier migration.

Zero the whole buffer before writing the setup data. Once the setup data
is present, preserve it and zero the remaining state area before each
state save.

Fixes: f0bbfc391aa7 ("crypto: qat - implement interface for live migration")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Found by review. Compile-tested only; I do not have QAT hardware available.

Changes since RFC:
- Drop the RFC tag and mark the patch ready for application.
- Describe the concrete userspace exposure path and add Cc: stable.
- No code changes.

RFC: https://lore.kernel.org/r/20260817042613.19855-1-kmehltretter@gmail.com/

 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
index bf2bae78a40d5..d8b961b2f2f7f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
@@ -837,6 +837,9 @@ static int adf_gen4_vfmig_save_state(struct qat_mig_dev *mdev)
 		return ret;
 	}
 
+	memset(mdev->state + mdev->setup_size, 0,
+	       mdev->state_size - mdev->setup_size);
+
 	adf_mstate_mgr_init(vfmig->mstate_mgr, mdev->state + mdev->setup_size,
 			    mdev->state_size - mdev->setup_size);
 	if (!adf_mstate_preamble_add(vfmig->mstate_mgr))
@@ -934,6 +937,8 @@ static int adf_gen4_vfmig_save_setup(struct qat_mig_dev *mdev)
 	if (mdev->setup_size)
 		return 0;
 
+	memset(mdev->state, 0, mdev->state_size);
+
 	adf_mstate_mgr_init(vfmig->mstate_mgr, mdev->state, mdev->state_size);
 	if (!adf_mstate_preamble_add(vfmig->mstate_mgr))
 		return -EINVAL;
-- 
2.53.0
