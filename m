Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210873246ED
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554688; cv=none; b=oTj7RnVTi3cNxm42OwZ/3HssbcAjuOirUuJvji6PC7xzPAZepPU7Y7LT/AXSrjtGC88bOD4Qv3Pv5yigP33kNl4jks9Z6Eq1ZWC46eWC9q8q6h5QtI0W8u9bpIEl/sb88UovJYCAWDKXMdAC6YZew5jqivdlghcI52lROng3Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554688; c=relaxed/simple;
	bh=lFFXKHxfIHHvNWw7khvWfQiP8CRnU7yZn2Q4kww3yLE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h0vrPT2xJBm7o3y4Fh20ENhNrgnOfEwZnX0GnD7vEEvH3a9Ts+iatcZlSeOuMwCILCvqoVeZUKcIpwLy1djGfBJsvaJJi/+qhXGFcwUqPaQgUgPuU1dM/emXClUi2lVzi9ssE6DRLYDMMX/sopTL8ibif8hvZzvNKwTgGTlJpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PELN5ruT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PELN5ruT"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85822059d8so2412969a12.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781554686; x=1782159486; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBqFtiSeOSQRIEswK+IwUUFhan45ti0foUrddU+Y3VQ=;
        b=PELN5ruTKG9BEwnkQWVXEDyjxGqydIOdjYm61sJFatkejnandNZ6UIqrdbPFktCXWR
         yYFh5hzQYsDR7tm6s5FboXHYVy01wV7TZB0SfpmbLkdEKtXyApYZdZaH8RWqrY4K4CNT
         QphY4pH9etegBjBn5vwrw2baUAOsceA/De5FG1b7vX/mEjPGi8KCMmZE7BwJjrakRDyb
         TIrLpauoZ/AULHMgxDsTIV/krCg2JxRYPZtsJhPKB6/cpv5pUgypPP5ZQL3mUam0tkVd
         f62QlyhsvUkpPw6u3JsjLVI8Yv3My/CM/g+nBiwqjKKRMJ6TT+VbFYaDecY4+3W8l8BC
         JTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554686; x=1782159486;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBqFtiSeOSQRIEswK+IwUUFhan45ti0foUrddU+Y3VQ=;
        b=kn83+Cldq7RjKgpZu8sRaYeGiC92X06uHt5enYhZwq1iMCpGoZPI3CtF0EnlhlENEa
         WjpqdEjfGL1elSX0MkKyhRQhJL5GE1LZuqg4HCEoxaKqPRGnj9bBpADBdtSlGn1Pr/Dz
         w0NkHuCpsDjORs3Cf4WB8q8KqTkRKOK//R1UDC6kKhRKETm4BZn5siVIZUmy8S+LHBvE
         a9JH2Dl5agSUNN8L18vpzh6pSHg6y8tFPRT6E7znTGIF9PsXFxD4q8VTyhue907byXU3
         fbuLzIBk7F+lPkFqeZDQcPjxCeGdAbofwJLHAwbkNrHjcGfTQIyelzk0TNfN8udQQbhU
         V58A==
X-Forwarded-Encrypted: i=1; AFNElJ/JCJ6R9uILGG3TjEhCRC0+gRSEkKUZoiysX8C2uqyGOzWG71FsBCGXUIFFVVF3jd8gqAoxwCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyllzXwzsk0u2SYUOKPc/F4o9RvEu5g3fJPxENgiPheNlk6aOf
	nH4c9jVR3KWHwozXW4FAlnTZntAuzgwfzuUhEuYp5KkYeEKBooou7qky
X-Gm-Gg: Acq92OFk0n0pmHG9aXtXLG76uc6+scZNm2WQN0w2PQ4Euq7Pwv8r0W/+MqahCZw5+Ao
	jUha35ImgoRkOQ5Rv0sdH3vU4XdxXwUksEjiPiufST+w2/yfIlbaNXT9udVLVugadbDKrXkOdrw
	hqHpTL12msLcDNAq3JCwDHcma2+brn7NztWtXRaBv1cXF1G2AAbf+QHpHKugiffUuldzPeK12nh
	SD0r9cU3lt2l1zUW3gOFf16oc5sD4YWW0yKfNE4D3yzhU80WiYmft3qy1HCSeeRJUroM97FcT0D
	6zNdG9Z2CCp5E/nPwZxF6fuZxgrPplUVLIofgGxj8ViT9aOQzltmy1Y5/dTkTdVfDyvtTgJPqkT
	AUQSBflgTAqL5mwi8tIUs+gdpzFy33SmdYIazRNCZWJYxKkAunTp8Xh8UQhhXY5q4KS1AQfr1UI
	1Wb1qP1ZDO0heILUAknnJI0i696OGARIFROhhHImwvTWMCjKtZyPUgjf904tGLZcPNDvut16Ooa
	eUa20yWcF2baZ111Sjr
X-Received: by 2002:a05:6a20:db0c:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3b7e4baf716mr580096637.46.1781554686460;
        Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([103.129.135.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186aefsm9576342a12.15.2026.06.15.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Use caller client for debug BO sync
Date: Tue, 16 Jun 2026 02:03:00 +0545
Message-ID: <178155468039.81818.12173237984867749651@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

amdxdna_drm_sync_bo_ioctl() looks up args->handle in the ioctl caller's
drm_file. For SYNC_DIRECT_FROM_DEVICE, it then calls
amdxdna_hwctx_sync_debug_bo(), but passes abo->client.

amdxdna_hwctx_sync_debug_bo() uses the passed client both as the handle
namespace for debug_bo_hdl and as the owner of the hardware context xarray.
Those must match the file that supplied args->handle. The BO's stored
client pointer is object state, not the ioctl context.

Pass filp->driver_priv instead, matching the original handle lookup.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdx=
dna_gem.c
index 6e367ddb9e1becb8d03cb4badec25deed38a851d..6c16b21994abc8f0ce58ee6dede21=
9a84ade6825 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1027,6 +1027,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *de=
v, void *data, struct drm
 int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 			      void *data, struct drm_file *filp)
 {
+	struct amdxdna_client *client =3D filp->driver_priv;
 	struct amdxdna_dev *xdna =3D to_xdna_dev(dev);
 	struct amdxdna_drm_sync_bo *args =3D data;
 	struct amdxdna_gem_obj *abo;
@@ -1061,7 +1062,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		 args->handle, args->offset, args->size);
=20
 	if (args->direction =3D=3D SYNC_DIRECT_FROM_DEVICE)
-		ret =3D amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);
+		ret =3D amdxdna_hwctx_sync_debug_bo(client, args->handle);
=20
 put_obj:
 	drm_gem_object_put(gobj);
--=20
2.50.0
