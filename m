Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857D3EC83E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232279; cv=none; b=mCdta7T7+9M2rxnm1XEPYM7zWsug/hUVj4EKNk+fx7bWQC5Tp/cPgxdR2F+AUFXZKxSRusEpy3SWkv4CeYesqArozK6p4YJrp2CsQZJyCKxw055vxkefDV2CovniL8ohHD8RMdpqJk0oO8sLys2Pe9hntca9Rje6e59dGqkxA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232279; c=relaxed/simple;
	bh=v3TaFSXtrpgJJmBg3R3loXYUVcw08+KzvCFhhEKLa3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbKpU0NxCzscGCsX4HwypI03uvjQBqKgAMctdpxjU8NYiSL5KYHvJLH4SeZBOtKtUHNu1Y+/B+u6uAqtU4SCdOzdPatQPUUNgTjV+xTLKcpeijTu9J93QY1csbh6jTUkXszpZYDkGESnBy4rv/YuTZofENIYXp5ZqvzUx36osQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNJJoh7q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNJJoh7q"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1204954a91.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790232277; x=1790837077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbB99fzKqqncd9v0PrpyQHGW/pl7V8ppi+GHfHAQQBo=;
        b=sNJJoh7q3fOYUFhvca0LAHQkb2mjezUVV1oOqAGZ/GHR18bMswzcFC6jEL243qvaCK
         pzWEtcVCTBQNxUF3fTIqf17p8IPY2E68/erT4Qq7oM6n3zHeS/LP4eDJESk1tBlFBsKy
         YMlD8vDbieshS37zrOF9YW4PLN7ue4qR8AY7eCl9YPAL+zSJZc/eRjh9QW7/uI+blkP+
         VUD2MgEPYE32NORcNt6yq7m/qqZq6LCV0BcQ0RfN7Vt75TevmRaaJ6olk4HpFO2+v+SZ
         7PKeua4ek76dwAFpNSLuXTP07lRNTDWkkg/VAqHhy7D0v0s1sXotIQ/NDzqKPhiCjTH0
         DWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232277; x=1790837077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbB99fzKqqncd9v0PrpyQHGW/pl7V8ppi+GHfHAQQBo=;
        b=idxGca0WMStuP7uLh+HNq/iacCRoyAnjNbYe1vZytvry8REgj7EtebzGP4arXQABsG
         5qzB4SvZpmQQ/o/nzQ1HmYv11eeQ2qPwOrBr9II64HFe/yXj8HoQD2moYX0dheGnXIAv
         FkW3PTvuOFdZi0W2TGdcXSam8SPJodPwIlcsij6Uyduavuu0TVoTrticO96WkZz6Il8E
         PbmdGOcedkUrtZ5aAgsemuFQW8HYHLbq2MOUC2apwIhulNwLQMYktRJm7PScDsZhk01O
         Ed8oll/AYlDkZ+bUvQX9uGwMLVoul0qgydtGwPrtznzJZO+7czViaWwnidqVtEW1iguf
         O/fg==
X-Forwarded-Encrypted: i=1; AKwUvBz52KBtGxO8aT29UFMtAe0cHai0EZutoRQWldN9gm4Uz5g8Jmq3ErCeiqxbcQynBXJr48KO/Do=@vger.kernel.org
X-Gm-Message-State: AFuF++lzNmxe3CpxLqaiGRi6xXa45JSjW9qc4Di4QuxmqZju5zJFEhHg
	3DIJh5dH/2PwOEDt273mObYKo0Fh8GTZWlN9WLFZ3JWU45Z2DyuLDIjI
X-Gm-Gg: AYBFou1p0pX88PcVtrdGIPKUK2zG0ARFT6pT7mIFqWuu8Pj5JSItRf9PsbfSh7ls9G8
	5riCPiDOoIvqwF7PK1e1+t/QiDfMyn+V7SgbN9kQ5MqZGtMVZ9E+AYy5QICbS9GF6wr0BSQyeXQ
	IpIw/pi+GWXTcgP3dMGi+q+0QAPM4y4W+uZ6yBctyBo6y/FbSI6QzwDHg0RjxnqNKX+5Wt9t1sR
	sdRq0qKmYybeptdo+Cv9zTJIAmoDalnOYncxMZQt9c8/noBECfFuqZGzMmTngmA4ZYGLkgN8ToE
	jZxFVPCV2oHjGMkSKP3F7fqnqkqyJVNBD5pIzIJ/S1ZBQ+NfgOfaN7BhzG+JuWCSMN5DuP4YFMR
	tbITznzf/jx4LO4OYY6ObIDCx60f7uhBCIdHT2l574+ZsaSGlXnqaMhRC6B2ThU32/nkQFPTpWx
	7XEWAJs7m93uP1Byv+E+gB0L24ZId9AuonH1CRNeHwGZ4HWjGLSQqYd9+enNJEkRelCKxM6jWIS
	whuO9ntjKLXV98UC6zqK+gOQFRLWIdyIC1sVllkfin6xg2QZ4yyBdpkykADELIXgDqCUV75QqeH
	UEkZHwlC6w==
X-Received: by 2002:a17:90a:d603:b0:39e:6c68:1550 with SMTP id 98e67ed59e1d1-3a098969ba9mr1148247a91.24.1790232276784;
        Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa0bsm2960830a91.8.2026.09.23.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/2] drm/udl: reject short USB control transfers in udl_read_edid_block()
Date: Thu, 24 Sep 2026 06:44:33 +0000
Message-ID: <20260924064434.2541959-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In udl_read_edid_block(), usb_control_msg() requests 2 bytes into
read_buff for each EDID byte, and read_buff[1] is stored into buf[i].
Currently the short-transfer check tests ret < 1 instead of ret != 2, so
if a short USB control transfer returns 1 byte, read_buff[1] is not
written by usb_control_msg() and retains the previous iteration's byte (or
uninitialized kmalloc(2) memory on the first iteration), which is then
copied into buf[i].

Change the check from ret < 1 to ret != 2 so any short USB control
transfer fails with -EIO.

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd and raw-gadget
emulating a DisplayLink UDL USB device: on the unfixed kernel, when
usb_control_msg() returned 1 byte for an EDID read (short transfer),
udl_read_edid_block() accepted ret = 1 and stored stale read_buff[1]
data into the EDID buffer; whereas with this fix applied, ret != 2
correctly fails with -EIO and prevents EDID buffer corruption.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 1/2 as requested by Jani Nikula.
- Added testing details in QEMU on short USB EDID control transfers.

 drivers/gpu/drm/udl/udl_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
index af4cff2a7c51..b7c462436573 100644
--- a/drivers/gpu/drm/udl/udl_edid.c
+++ b/drivers/gpu/drm/udl/udl_edid.c
@@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
 		if (ret < 0) {
 			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
 			goto err_drm_dev_exit;
-		} else if (ret < 1) {
+		} else if (ret != 2) {
 			ret = -EIO;
 			drm_err(dev, "Read EDID byte %zu failed\n", i);
 			goto err_drm_dev_exit;
-- 
2.55.0.1082.g2b9226bbc0-goog
