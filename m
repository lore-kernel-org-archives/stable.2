Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3523556BA8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991189; cv=none; b=WbRT18uq33PyPFnBZ3pEgfz7f4RpFfJhHaU8yioXzpLqta5tgTJrLa51/9Nfz8I4iSS1VWuoVzEV/JPjwEPfyEvoAeEQwr+KsYUAfSl17VMaQDJdhctaLVJOQbI9BAhIQYPBCnCL9UM8DLAosGOu7Kb3JCycDvItAk1pS7SAUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991189; c=relaxed/simple;
	bh=zZ4wrRNrUSlbAIRtWsrlzRF+70WmEZHyaWAMWVXvwfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL9EhBW4qcFgkuPIFSHvpJqxQwWl8BG7apksReLk0Xfq6/nR/iIOBZv8L5/0PbqZ9ZhXcxhCHdljaARX0bW4PZO0adAB/dbJn9IhvPZU5Ncy8GJ7CqyGov8sA4UjKwcaAOSbrLyv5zog2IH/rC4ne7uXseS5/Amag3WDrpnM1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=S9URo2nF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="S9URo2nF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd633ef819bso61568a12.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991186; x=1792595986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yt2lnf8MDVtM059brPwM3fIP69zsoLXWM8Qr1rtqseg=;
        b=S9URo2nF+0CudypIdTX8NSiWbxYibg0NZRPOoDJ0CkmdEqJM2erLo8sQIKCivKxMeO
         stSFfiQwn9ejRT1d0cSqePf5sxOJ8uHoamXflm++N8Y+Pny7l5n89jT8wfPBuZwkwRmG
         UNzGGaf/+bnZT815K2gPa6HC9e1PcKdhxMj48qkIMaTqy9y1Mr36+ZuPZhYrtKrXDO8W
         M+rG/D8MzJcCNLs6tzGG4W/cNVHAYCeqbB46P+nD8zxDpF2uA/OT6lolHRADuh5Yn/Jc
         ls0S2DwgpdvgeulzUyufP0rU3h38ML6CTBJFPewN3O0xFLxDRilIQ2g64l9cPzDBJNhD
         VLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991186; x=1792595986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yt2lnf8MDVtM059brPwM3fIP69zsoLXWM8Qr1rtqseg=;
        b=TKwZG8meME1BAp+A8lEjIu000ipVnmSv8AfvzjDjkQc9OCHpdijkAlcdzvjxjDd5FM
         +Tka7Q/d7MN1p6YARnYDW1S5hOJxQXcs0opcOgvgUJblYv77eIeaBoWzqaKxPxHFIHwT
         MMaJyTCbDlnhhQZzWgrnHWtMhkfHdQclYWcepm1fZF5GQaifOuoioChrQUTanCXUVy4f
         Jx9tP8hWs++mudJsq13ZGKLPs9U5m1nAoAIOZDVWjtA1NtEzP9BR2jvHtzGUdBzjVkfu
         Fmf8wFkrfAVMZKbeqNCz09OPK/I6OHA3Qj0weHpK/EzlD3PFp6p8012IFaEPZK3lJY/X
         tMvw==
X-Forwarded-Encrypted: i=1; AKwUvByFqsUkUVNW6V6Px/x9rgukPkH0gW1e9ifs4xoEWaH53ZjB6ptvF/iGW9KbTe+9hQmGHkZM2/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkh61G9nmaoCjWzALmsGwpsWDbJ/896RiKrH24ifC6LNSVo/sl
	XnI4dfVcBp8GzWaJK48KxGRrqz8lTx89gXcyF8MaZSvGYkNrEUAGpECnFDqQqUAgjyc=
X-Gm-Gg: AYBFou2afaL6jzd7MKA+xf1e07UishNF2EOsAGv6vIo+tYCV35cuj0j/2pOVz2jUfyc
	q6QJgKqK+f80gYSArSk+lS+y87A+wW9hkh8CdNc+gvZ/dVnfvq0L+gS5EvN+wWOWR7PP729qkis
	26cZYjapzS1ah4J600r6PEDRhVMN4hIqjFqxOVZhC6H/W/MK3sU1k9dXQgZRn0S2dSKMAWjueEg
	hWy8hsUjhoNf7UwtYIVbunNzwtumosFVAopDpTbgibQJ8hoe9AE8ec398Ku2VGbZfuXpgW8hMmm
	4ykDcisncUvFkcRc1Y3r+6odeFVtmDiGkaRceIwNTtdCrDG8IbMs0qcPOV/BAXZk+p5905wTLrp
	P0S8nUzdx6ygECqhnUCAxITGZsxOsvYddMZTYc0ca5PvokDNRaBO/GEXOmWVZjx/iTCbcTNFSTc
	zRRpNDD4KtsH+XEsslRDLuss9cF8aLG1edUH0+jAz2YEhLeTXy8Ox5FcGUpMF2xPK3dSeDioi9e
	siwSRdPKCV/ekYivKBalz+iFOyxPgn/
X-Received: by 2002:a17:90b:574c:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ac83c10467mr1056621a91.64.1791991186183;
        Wed, 14 Oct 2026 08:19:46 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac8d40e7f3sm622450a91.5.2026.10.14.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:19:45 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 6/6] scsi: mvumi: widen the flush cache loop counter
Date: Thu, 15 Oct 2026 00:19:14 +0900
Message-ID: <20261014151914.3632701-7-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
References: <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_flush_cache() walks the targets with an unsigned char counter while
the bound it compares against, mhba->max_target_id, comes from the u16
max_devices_support field of the firmware handshake page.  A controller
reporting 256 or more devices makes the counter wrap back to zero before
it ever reaches the bound, so the loop never ends.  mvumi_flush_cache()
runs from the shutdown, suspend and remove paths, so the firmware can
wedge any of them.

Give the counter the type of the bound.  It is assigned to
frame->device_id, a u16, so nothing truncates it again, and target_map
holds round_up(max_target_id, 8) / 8 bytes, which covers every index the
wider counter produces.  That last part needs the earlier patch in this
series: without the reset check it adds, max_target_id can grow past the
bitmap it was allocated for, and the wider counter would then walk further
past it than the narrow one could.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 07cfac9276e7b..090ae79ec8c3a 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -769,8 +769,9 @@ static unsigned char mvumi_flush_cache(struct mvumi_hba *mhba)
 {
 	struct mvumi_cmd *cmd;
 	struct mvumi_msg_frame *frame;
-	unsigned char device_id, retry = 0;
+	unsigned char retry = 0;
 	unsigned char bitcount = sizeof(unsigned char) * 8;
+	unsigned short device_id;
 
 	for (device_id = 0; device_id < mhba->max_target_id; device_id++) {
 		if (!(mhba->target_map[device_id / bitcount] &
-- 
2.43.0

