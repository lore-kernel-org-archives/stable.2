Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830C46DFFC
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049198; cv=none; b=a7/oEfvJ30dvz600lTFPeiEn9rTlFum4B16I7T3PpgC+KwdlKXE2ikdFhvIIYYey66MkGj1Eq1XcRoetiaX9z0jCUgrqUbcc5UkwD1B5x0rYYLA+n0+SjNZMs0OskAplUh4rvVoDt33M7NqOt2rAJo4BU2jTTQrH6ILcv5sgBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049198; c=relaxed/simple;
	bh=55fngw8U7i276yUTXQntdbIZF4Wd6ep68zhxSVkxCO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkhPS2XC9d5gdMi9RN+bGWeOx4YUUMvB54mFVOC41BVjvgubQIXwU1j0/mSRdc6QL2W7IWqDNzBNC9YPGOKvBr4bYVMcDoh36+fHIQ2lGL0BcDlqh6TubcqapdsvdIzqCMPvDGmWtBk/NVjmX2du3TRVcgD83NPVfR4btisgHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=GJI3uEIH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="GJI3uEIH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e940d5d2beso5989365ad.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792049186; x=1792653986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6VprNe7yjepyKxDyWl/GS5n+61wlhCAhAo3qvs5zaA=;
        b=GJI3uEIHj20+6V+mGjtCAY8MK4iFB8mWOlPqtEMJS/ilIx/Tpk8bb7cAMCW+Qgmns7
         I+faRk1YMn3Bygc+hMZTQGFdp7s7mk0jKWXTiF3ANdHFnDeBjrfmzNMvhKyvaeaK+2h2
         RKVFjTkXPMLzFovHLSePSyMgebS7a5XF1bsDjCBFjW7Q+g8PzxJjwMiZCWBn9f7QcGw7
         +IJUicSt9v3h4Dgba5PqLZYvWMiDxRkJ4ALUdc7Ef3Il3BrlDayMIPbhKPnDVoLrXrT4
         f6R+EkNN8vH0vQMxCFzxaUfS2d/ltBca12OgDFtmlg8D7GJwKCfmEgu5mmbZ7ioRWjOz
         LPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049186; x=1792653986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6VprNe7yjepyKxDyWl/GS5n+61wlhCAhAo3qvs5zaA=;
        b=xQ7Yd2Jx0P+QUSwrPhRn+j+kWXnuw1HBi+Ruo2X5E2ggspYoeXzOs245QVPmw0cown
         erGXQ+4A5wcoUeVbov3Ck8orgpalVZvtiCWa+IjH+/x810CkPsFJQ4Sr2atfX2ccTiOP
         ndMoQwnxgUyjRHkZ9vTIAs0Is1gjJS7iO76u22F32IbqgE/BbK+rCpx80OS/PNJOU6VF
         j6s6cEUyUH15fBNYl9eKY3Uky7OkotdXLFThF/4JiNkwNS2Xlk87ow6Qke3dggJHQrnW
         zgV/1Uij3AytK7xRS6s43Jvzk4PMr18QZhPs33FAU9lI38rYyM1u0MJHlU6cN4TKa+Kr
         oaTA==
X-Forwarded-Encrypted: i=1; AKwUvBzVoL+Abk0V3LAXxnwtwBJ4Ce9V1sQzidh3Tf2K99Lc9ZiwTHUuYVvEo3eIXnyxik0w2vogNO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgJ3kEgSKYL1pcg17VlkPKlk05VuSCeJ/r/xG1gsyG257QQ+Rt
	fw3zOy64C/Cb16KJMFhbJa4s54pWkh/Y44FDL31aj268bhEhuR98X28yUrXtP7dCf/0=
X-Gm-Gg: AYBFou01pWOJ/RyzGRyiPrD7nqIk0vKq7+ovcedj5A2d0dVGiez2jYtV5teTPL71K5o
	IPHF8VS+jp13KFLh8TbsvqsMR7HPpAmBkye8IwW0K9vmLg/nMRr3VNIyjdYRhNUtjtEECeg1ZMZ
	EL351Gve2zoaWghIdbEGr9jZSB7BJ+M9didqQHAkPn5yYFVd4wn1c+FhFA08IpkKt4le7d4iE59
	5ZaMQTcMw28ynINZaRRfIpLvx1wmyjFsD2Eve2P44JGtRYHnQuyoEPoh5Ni0ZxZR4Rj8XT/pipU
	NHok2GoYOZliwZ8YnTmyUT5xJ8THQION5KV+2sCk8xf3AMEEbBQaNjRh8RU0aUr9SU0Omzg+tv6
	KufdU1QqkrpslYWmqZlwpKJMAWn110kJv3JD54yONy25grgl/RlVD/ewBxv9sslVItPv9Zozbft
	lBfnDj7o9wbrCDINMJcQNSQrBlfHRMaytM4GaC1rg+8qoo5yire1XgJzDFEg04AGtuK5qsIcjKM
	pM16A==
X-Received: by 2002:a17:90b:2d86:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-3ab3a90b5f4mr13828970a91.15.1792049185606;
        Thu, 15 Oct 2026 00:26:25 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac937c4e7asm1754279a91.3.2026.10.15.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:26:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 1/3] scsi: aic94xx: bail out of escb_tasklet_complete() on a bad EDB index
Date: Thu, 15 Oct 2026 16:26:10 +0900
Message-ID: <20261015072612.4144043-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
References: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

escb_tasklet_complete() derives the empty data buffer index from the done
list opcode the sequencer wrote:

	int edb = (dl->opcode & DL_PHY_MASK) - 1; /* [0xc1,0xc7] -> [0,6] */

DL_PHY_MASK is 7, so the subtraction yields -1 through 6, and the
function already says that anything outside [0,6] is wrong:

	if (edb > 6 || edb < 0) {
		ASD_DPRINTK("edb is 0x%x! dl->opcode is 0x%x\n", ...);
		...
	}

The block reports the problem and then falls through to let it happen.
edb is used twice afterwards: asd_bytes_dmaed_tasklet() adds
ascb->edb_index to it to index seq->edb_arr[], and the out: label at the
end of the function hands the same value to asd_invalidate_edb(), which
indexes both escb->eb[] and seq->edb_arr[]. asd_assign_edbs2escbs() gives
the first ESCB edb_index 0, so for that one edb == -1 reads
seq->edb_arr[-1], one pointer before the array, and dereferences whatever
it finds.

Finish the check the way it reads: return instead of falling through.

Whether the sequencer can really report an opcode that makes this zero is
not something the tree answers. It is firmware loaded with
request_firmware(), the done list opcode is described only by the comment
above, and there is no Documentation/ file and no MAINTAINERS entry for
this driver. This is not a claim of a reachable out-of-bounds access,
only that the driver goes on to index an array with a value it has just
decided is invalid. The intent to bound what the sequencer supplies is
already in the same file, in asd_bytes_dmaed_tasklet():

	size = min(size, (u16) sizeof(phy->frame_rcvd));

which clamps a device-supplied length a few lines after indexing
seq->edb_arr[] with a device-supplied index and no bound.

One consequence worth naming: an ESCB dropped this way is not invalidated
and so is not reposted to the sequencer, because the repost happens
inside asd_invalidate_edb(). That takes one empty buffer out of
circulation per malformed opcode. It is the lesser of the two, and
recovering the ESCB instead would mean choosing some other buffer to
invalidate, which this index cannot tell us.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aic94xx/aic94xx_scb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_scb.c b/drivers/scsi/aic94xx/aic94xx_scb.c
index 08c8dad9ad621..d050e5325b943 100644
--- a/drivers/scsi/aic94xx/aic94xx_scb.c
+++ b/drivers/scsi/aic94xx/aic94xx_scb.c
@@ -421,6 +421,7 @@ static void escb_tasklet_complete(struct asd_ascb *ascb,
 			    le64_to_cpu(ascb->scb->header.next_scb),
 			    le16_to_cpu(ascb->scb->header.index),
 			    ascb->scb->header.opcode);
+		return;
 	}
 
 	/* Catch these before we mask off the sb_opcode bits */
-- 
2.43.0

