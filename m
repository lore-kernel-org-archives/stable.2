Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4732B10B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149174; cv=none; b=bcteJcLRPBWddjNyoscmIKM0JcjCLkxfkIemdE9e7dgPVGztARs/vewZdIN2fTY29IHcNUnfdDiOnZNUhrl92vtxouO5366gMqdjErf7G+hc7xO5BoUiQseNAIo/pF1MezEneeHSNcUDC60LDsMPsPJkVtSqe+LBIkP7D23pSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149174; c=relaxed/simple;
	bh=Lmqd+koWddn+ibQQDLmnYPRN5lrKZdaYwps4HHvieTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHivwbcaHAKsJ33aCYFbNZ4JsKshwKKi98ZMMQ6cxJ+Uh5CiWUH45tDb4dDuZSJfH8tK5yLvWYdlO5Kxy6Sh7Ssv+Cbp0LEbSE2ITRNZqgdujt5Shwm5CYWnBeM2jHzem6Bpoe3ZoxL8WZUTf8w5inCSgpAEYgcjDOeUHqITeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVpcvsgj; arc=none smtp.client-ip=74.125.230.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVpcvsgj"
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3a59dae8ce5so3835051fa.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149170; x=1790753970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IzZ+cNf2z4J5z3qvFn6/NJ8ACjL3I/i0NM3vzaSh4n4=;
        b=lVpcvsgjfGwqQDvCugOFWspvi+f/yzUhaaqli6iYdMAI9ZIqzexzt0XhOp2KX77kWR
         4WDd5FQpiiTXMwc67L5MBJ5Fe3f0Qni15rad9pSap6zSBRlYMn8h/OKA474fkD7eEuWs
         zYbznFqPZvEocfrxJMGW/4wyqvnkUoSQ6c3LVemanheDOc6d4Nv/Gb3Y7mWroDez87Oz
         T6oIehHzCcr47wSzArZdI9xenDLxb6ENV0VRmHNGcE+nLN5sOLdDWEoWjjb0D+dDUQ6Q
         3bdBWhqFA27u8j8/U7h2iJerDel/w668V1ukn0IJ9IhB5QEa3z1Ppvzc+DTCuYb0p4Bm
         0tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149170; x=1790753970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzZ+cNf2z4J5z3qvFn6/NJ8ACjL3I/i0NM3vzaSh4n4=;
        b=U956cx7Cmlf5t5sqgXdEreEXNATI0wP5jGbhow8wEerYO113UyuMFPm957y39xsulV
         PViVvfNfi6+lojdRLhTw71gKUrxPv2gk6xOae6+0tsIC1S4tE13+9f1CAM+ZdFGjpdWy
         rCE5+gMqL8FMzms5oZZuxQAuwvgsuhj61v9GtTNgkfScUqheZXn4W+k/1xs+j4DQwaVe
         voM4Y/mfOkfJEeKDnZENRXuDGZ/hiFTjg5kRVszruIWvxMN21W10qP4a0h6+eBd7/bIo
         yMsrEBHKTPFXAkMJqjepuclcAIVp0h7ReRVaHniKW8gWlPlZSifMfz07Ta853BH4aqD4
         pBgA==
X-Gm-Message-State: AFuF++meaSe0Hn44YXJjX7rVaenYztPy0pqjrnBWMjMg1MKw7/VZOuzc
	Irq+nRC76fGew7T7mDwqx0nERLhTuU4svHCdLBJ736LwDDg4xEjKOHg5nMaLQ7D2Jas=
X-Gm-Gg: AYBFou22co0b0cBAgFY3+fGpRGHkGmQWD+8R3YzyoTAPtrm6g1t/83i/nI0GToTc9sd
	+tVU7xOe7m8ORxtC+8hoTRPSVjmhb9xHLrU7JYRSo8PWPveBUWga+1poxnCIHDLgVcm3YYTIocY
	dRda3hBpC4S04/UjjjhM2tN58rB7YbuRdkUYQ6YY2uJMjbH56s86KJZZkkNeW/1N4OksBvH8419
	Ir4iVJyniEJ66aQ57WQFe/BPbZUzJ1ZC9lom48LDh4tyNj+NjxDXXlvyfJ47GDS61WDVMzL96tk
	OhGv7ygjdKoH9GEomjPqU5vLqdPkRJvmcISvj23VHMOIGYRyUJ1YK838nexnSVx4kurD1xFrTNa
	GolfehJ4JAUJjSDHBgzVNQZW9gz1E8QqYjf3AVYkGavXyA2wRcPvjtb8DhldittPPfcyBhe9oE2
	1fYCvHkSMU2k2QQso3JLXqmohC7i9gk2jTytfSm5Myw8psNxUWntcO2N44lWOIPtDsxpKgfr3ZS
	7pEMIat0UYkHYPR
X-Received: by 2002:a05:6512:3996:b0:5b6:1a7c:59e8 with SMTP id 2adb3069b0e04-5b8d8ac9b9fmr472193e87.66.1790149170031;
        Wed, 23 Sep 2026 00:39:30 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8580568sm395754e87.34.2026.09.23.00.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:39:29 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH 5.10/5.15/6.1/6.6] drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()
Date: Wed, 23 Sep 2026 10:39:12 +0300
Message-ID: <20260923073913.39211-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

commit cc9a8e238e42c1f43b98c097995137d644b69245 upstream.

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Roman: added parentheses to the 'if' statement, matching the upstream
commit. ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2025-68190

 drivers/gpu/drm/amd/amdgpu/atom.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index cb6eb47aab65..0a7666be1dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1228,10 +1228,15 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.ps = params;
 	ectx.abort = false;
 	ectx.last_jump = 0;
-	if (ws)
+	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
-	else
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	} else {
 		ectx.ws = NULL;
+	}
 
 	debug_depth++;
 	while (1) {
-- 
2.53.0

