Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686302;
	b=XqMrsL0tKumKjwAb7kRWt+lNiNfIxfGocd6m/WUobcm4X71/tLxlr/VWbNtM7qjKDhRF
	 yDxI40RqgyTENKOjk/6K+6XUoRAou/6SstsWn7ZuX999eLSvsDryL8mY6AA/mOrJzdVJJ
	 uuzlSStmps0Za4V+Q48s0/hkTQpMkzXrfYDbrPmJtqOObY0utbCA4wCpYAvefMxtsgeRz
	 3NF6nx+mjIl6EjI09OThE5zAMxQJm8ikZDlfqS9e0ZNQT8wFOHEgZmERt3/1bhjpzcljo
	 5qcv+AopNjHwweQc425fktoba/U8bGT98hMEQAjWyh6GdZ/6t/gnE5zngjGCC1/zuaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BYXUCwkPXhE2WOYZgJcFT+Ca8H8+sCFYPzL9CHP8/xA=;
	b=a/MJBI6ZFfSONG3CDSsucVQq7PKabg8C/aieu0z6sNkr6v5vFTZQEhWPfALKD1naZKOf
	 656EVyoIQviHj3PSDHZ+NiNsfSbnkfyHg4STqV4NGi/lLJg4l8+F0CDDp0WdvPy/sqb4F
	 iG8wHGgB7ccd9zvBghoQwuVOooPk3FHZlBmzZzkcVy99JdzemX61hmj/7DExorhrt80hC
	 W7TJPrv1lB1q7bMhcfzeiORxALQLjC4aPL03YasVx2jIPXXWDYBjW6/Dk2ZLpvL8rvszr
	 69mjoiVWQjHlD9cPVr7JXifCctMx2zZi7IEp/SRTTmU9XBqjianLmJ4DRuv94XFbgUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdWGRSa+;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540F606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 06:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C540F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdWGRSa+
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so988392a91.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 22:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793686301; x=1794291101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYXUCwkPXhE2WOYZgJcFT+Ca8H8+sCFYPzL9CHP8/xA=;
        b=wdWGRSa+d1G7wMGWQ3kVcsIu8QnaPYbLH27zMi7SmQORKsqMByHfw9zsaEQ1OSacQk
         Fx4Tu1yYv1cbAjyujStyK3RGbUjkIEZ49iKCbT4OjDgqcOwO7vYiB4V0e8etoUsRVWJj
         LMvyDtUG553U05EayY0Irf6g40naNT34PZT4qt5H9geoHSqZOWMc959vwuEGRm7gd0fO
         EoZ/mSV/OmdqSsfV98mcA9g64VAKXyOy6QpfsDUWAs9km6x/nVaMxUQb5KZFQYh7wzxo
         16BJQqKYVYN15LGVtoZ1zQSj/oUdpYtDxLeYnSwCXbD1SVS22wClSgRNETan+n618/SZ
         WR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793686301; x=1794291101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYXUCwkPXhE2WOYZgJcFT+Ca8H8+sCFYPzL9CHP8/xA=;
        b=RoIvV7mAZrIwdzMmCY9KyUclOzgprNBhDlYoG5DCPo0aTRz9YtI0maY/3JzBqQ8VXh
         HfO2Yhv1YETkQb3svk6s4um9qSGS1btRhMKIvWNSJZDnflAdPEwuP0ri5H6fcErIvazx
         t4JiJ5AoW3ZttQQ0ppXGpL3MDrysaiKeFMzYoUAV8wVqSB5ntQG1fliMH97WI7HF2XUs
         +t0znOUd7yDNb4v13kE+bR6sqbqbXLF78hAYyVIRUB228UngAX61/IFDpVwVfmmPz7jN
         Nfm2vFXCdGzKP6jkFejtb0VG/US39VtqN84Rl460sQ9kaGFxMEaY1n5pQ6E5yEQrHwV2
         PvRw==
X-Forwarded-Encrypted: i=1; AKwUvBy1/2+Y53KYLGF8si+653T4FdHYENxGZM2+VByaHSdaVHDNo1eWT17Jqm7soNdOra42hLlkYxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ggQod6TGVIfcxuVsni+71GGwIfZqj1FDOj8X1UexPH/PCtx/3
	3vhTepaMHnvV4a+rcqXcle5um5dpwL3FCJ6qt0bp4uKs5HHUmoPh5SJAM4y9V7iW5qQ=
X-Gm-Gg: AYBFou339QLQ2JTpRy5lbIumPpnbv8X+xtqa9OQcKIqZfFXvD55QrOHQ9moXggz1Qw8
	mRHNj7a588hiaC4gMgwOAjOzw3SmKK6LcpYxGhtT//bq02QYw08Hv1tPTMB0Mw//9y/RHMJCOiX
	voqjUe3ghy0EiA9p3vdwEqs4iD1b4UDvZL2Iwg6hJ3peryg/mJ8dbDl4u75G5fldAF+l3zmbGIB
	3zyvwlLcmedoH/nT2wahpniinCfSTjXaB7ef7ShzjHzbMMlGeLVHDgmJb/KfwwomRhrsUY0a8kw
	cpnSEPZ8uEaygKcv00QzykQvxIAfCFheurzsX5x4mYHOsM9UtlmQ9itik1cISb6UA2sLCchmvMd
	52iQVmjYUyBBRsytrzqtchVKCxe+WhtPlb+NDOp97y/RZddwIMSgc5hpWLkGR18LFr1xArbAwyx
	odOjhp8xcOyuJtp4Lup78jxyP6AyyfiFxaQhM5yrWxODf7ReAjL7cV1Gqtk8GTisI4Jodf0w5gt
	wGDHsgkmdW9BUAOaOGOg+E2F3HF3XRSiZgqiFSqjO3tnj7lUxmFwi3wn/lYzlqEPshj6NQPu78P
	iFJ+IwdfpNurwFQee7hVwsra/r7D9bNJP/uZrYhkFzn5LkijNRF9LcXR
X-Received: by 2002:a05:6a21:a101:b0:3e2:a9cc:3ecd with SMTP id adf61e73a8af0-3e928aaf420mr8144984637.7.1793686301096;
        Mon, 02 Nov 2026 22:11:41 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb363a62e3sm748229a12.4.2026.11.02.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:11:40 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: end trim runs at fully allocated bitmap windows
Date: Tue,  3 Nov 2026 06:05:56 +0000
Message-ID: <20261103060556.55571-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ntfs_trim_fs() keeps a free run pending across bitmap windows. When
the cached free-bit count of a window is zero, the loop skips it without
ending the pending run. Free clusters at the start of a later window
are then added to the old length despite the allocated gap.

For example, two eight-cluster holes separated by fully allocated bitmap
windows can be submitted as one sixteen-cluster discard starting at the
first hole. This discards allocated clusters while leaving the actual
second hole untrimmed.

Finish a qualifying pending run and reset its length before skipping a
fully allocated window. Preserve the minimum-length check and the cached
window optimization, matching the analogous handling in wnd_rescan().

Fixes: 3f3b442b5ad2 ("fs/ntfs3: Add bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ntfs3/bitmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 60b362f388d960558cd8ea65680df266e26dabd5..8875e6feff9c9715933545dc2fc173a191302ddc 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1447,8 +1447,16 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 		if (lcn_wnd > lcn_to)
 			break;
 
-		if (!wnd->free_bits[iw])
+		if (!wnd->free_bits[iw]) {
+			if (len >= minlen) {
+				err = ntfs_discard(sbi, lcn, len);
+				if (err)
+					goto out;
+				done += len;
+			}
+			len = 0;
 			continue;
+		}
 
 		if (iw + 1 == wnd->nwnd)
 			wbits = wnd->bits_last;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0
