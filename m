Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CE51DB1E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178252; cv=none; b=IKhAb15P9PqnUSSYgjfCzqeX+h0bQs/5ZOHRwoML98pPe1OX+SKYrMEKX4bGpzdf4uuJujusfiS421AkEWCtTIteFOSvuHvNuLThY98vvuVPHMgRipc2IZ5WhZLQ6YydpUODFGrTYrvIvlI0Lew1mZweC620IbftC7ngL+QmgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178252; c=relaxed/simple;
	bh=dEsuichCM0C4hCd03bd1KgU+6bKSG+a5n+EmuwGO5YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+IANsgoXURzaSfHGru0nfR/O2PjBJruY5LBukSOL1eMpOO1xDtLZcDz+BR/cW3I0mYn+CWyTv7DCK6y/CFfvwC4FX83iy6e7NT5MFs2fGL+Xqsh7eYYnc4sDxmEMG8+SEMCWdCRVJvtT1YSeGf63ecHET652A8hpw3iQJdmulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0ACg9Gb; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0ACg9Gb"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9a1536864so762762e0c.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178250; x=1790783050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HtKgKYLrxm3x6UJBU1QmDCl4UFfcngUzG8by9J5Mp4=;
        b=K0ACg9GbRkf2d2CqOgjxb6McIJi3fYYkRKp4+otdQ49rbixq16AjG5B02Kpmy1ba/S
         VxxTRZ/7GNuBl3KKRYMA8fKKxNKwzFZW/T18y9bEQOxj94YuKgrYHIcpwxG6vo0COwyX
         2Vo/3pMZN9GH1ixwaFXBFjMJA5fLf/+VM0mbHsSImNwwyXYZfwqaqWQIR8DvMLtQi2W0
         q1LEfXCpP5q40xcog22v2Hu26pqWG24XI7c41HEVcVd73+j6mI3BqsxwKwsFTPrdGn6b
         IeaO2VnMOWdj7v9N83GxPRpflVADb6Na8cjhNrBcNB2jaC2Z30lVHwFXhU26pL1RGjEQ
         xJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178250; x=1790783050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9HtKgKYLrxm3x6UJBU1QmDCl4UFfcngUzG8by9J5Mp4=;
        b=G/LVMDQ31h2IUwBS9Fg21DKi7j6LfuBH337qngqPTlw3NNaOSxqE9mkB4UTAtDnCqS
         5o2Y1nQqQKpwH+Wt2fj3Pr9vsHZKtsrRJZg/jYl7KVQ/hk2P2VhITX8lutgZbMqR6Lcx
         JqhqAvOTia9cJRinMsMjZhtb0J/sR8atq3NwHw9hdU+cx6/tiuOrtVmOs9Tn1VSN1wMm
         xV7BVSRFwNQPNA10LneAMSU+s3h07gLEbI/Z1OOjBZao3sTjLdYuD88oBtiQdLDeiaKW
         rKxgxaSLZJ9aJaTMRhw5bqf2DOYGzahlJGuG6zBiHxJCwZKeGvXcNgIZuOYPeOD+O5pL
         NPBg==
X-Forwarded-Encrypted: i=1; AKwUvBxeEcHSXdxF+CkfVZ8Y860k0aqVcl8QkIWERtCA/KFP9oqvHCB71xUO+hkVMJQGjNbeQVOMU9o=@vger.kernel.org
X-Gm-Message-State: AFuF++kW5xV78I+20JPYpNQWK7tbXtVy/GVYHAiHyLYgAWNsM1VW812g
	TrbW9MCtAkLg9MTwgoRk2BSSJSWT9G7nP/vByRz5Zont5gfrHGJDAyDe0SoksGsI
X-Gm-Gg: AYBFou0uvv4dmuW7kXIQCrqOBhlihJtSY+NiMBGf70xQTGyoVEhOa63DcbF8HrIGiil
	693GmZ4nhiCKQJ3xrCP3CdsnLLcLdUfwRPO6WNcSzlySx0DM8OttteFyceGObBUCIMDZK/g1hH+
	SD4a8mQ7xWscBZ14hoIrLD6KdI4U83jZWuJbXTAp/NiRCBY9B8lFQ/eTILPa8Bb6/7k8MruQboZ
	N0HkjKP0AqQSjJJGrxQByO//BI9pMSirmAJ0TC48+QIE9+H8OGsdRZfZCgZF1EpLMrImtRIH3CC
	i/A6RQtUSLdy9WvMgE2ed8r45QJxaslL6WEK+IzIa9S0WAZrSYgnxVFHjzuJSHn/HaY3buQ7kHi
	54fuJ5ejOoFKPrnLSpEyXxBeLN0coybQs2Q1NlbyQyWzqeHjcfqo34TJfyHM4uWzGZRlGOx5zi2
	42ize7MkpRG/+db4Y9ZerQDWfBzdqheNn4jpbchUIi3skDH6Yb6STFjHzcJPXQSYKPSU89dFmCI
	WQAV7/H4Qsj
X-Received: by 2002:a05:6122:400c:b0:5c9:a60c:273f with SMTP id 71dfb90a1353d-5c9f16b901cmr3577780e0c.23.1790178249808;
        Wed, 23 Sep 2026 08:44:09 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f04f02bfsm3437129e0c.7.2026.09.23.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:44:09 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in nested ATOM table calls
Date: Wed, 23 Sep 2026 12:43:57 -0300
Message-ID: <20260923154357.1319689-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923152912.1296884-1-qwe.aldo@gmail.com>
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atom_op_calltable() invokes a child ATOM table, forwarding the
parent's parameter space with an offset:

    amdgpu_atom_execute_table_locked(ctx->ctx, idx,
        ctx->ps + ctx->ps_shift,
        ctx->ps_size - ctx->ps_shift);

ctx->ps_shift is in dwords (set to ps / 4 in
amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
remaining capacity in bytes. The subtraction therefore mixes units:
a child table requesting 60 bytes (ps_shift = 15 dwords) with only
16 bytes remaining would compute 16 - 15 = 1 instead of the correct
16 - 60 = underflow.

Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
subtraction so the units are consistent. Abort the interpreter when
the request exceeds the available space so the parent table does not
continue with stale or uninitialized data.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v3: abort the interpreter (ctx->abort = true + return) when the
    child table's parameter space exceeds the parent's remaining
    capacity, instead of silently skipping execution (found by
    Sashiko AI review on v2).
v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
    ps_size, fixing the unit mismatch (found by Sashiko AI review).

 drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..af283cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
 	else
 		SDEBUG("   table: %d\n", idx);
-	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
-		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
+	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
+		if (ctx->ps_shift * 4 > ctx->ps_size) {
+			ctx->abort = true;
+			return;
+		}
+		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
+	}
 	if (r) {
 		ctx->abort = true;
 	}
-- 
2.43.0
