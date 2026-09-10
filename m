Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFE395D86
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073586; cv=none; b=u026ltyYPH1lhjaLenDowql6cxbkaGO/H4PrLKaAA25JH2f10oiGx62VdRM9goF9HSbCXTIYPMFSj7P+awDyMa4GagQTqEqPc5Wrqlq7P6j0K9VHfEumbGpDU/oh8ESP/HURafd1LP8CBpFqnNX29sRJIrJXabo0KJXEE/tphe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073586; c=relaxed/simple;
	bh=4mRR/lct3JxUI7us99LWGMyA0AfdcUxcoiGG5tWdAAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMSO5AtXhntnWP5dwHVGT8N64+0DIEi/u054jKvT+cvRiYJoqHz/lyvtIqPwKst3klCBmQAB+QmP7B1XTg/of9R0Q6w9+3FTN2rp9B2Qb3Xb9ATd7LPXZD5mtiH+0C8kdZ5RqzFFTxge8XlMrHurHeQLHJ/zjLXuKnALuhJ/3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu9KASFl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu9KASFl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so1571465e9.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789073583; x=1789678383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mCkJNb+QrKnJKj/QcqFSE5iIzRjiFJzvF62FVz0jZM=;
        b=bu9KASFlGGGxmRLJbDyzgrVwnhC3NefLPjdz491XeLiDdncfYVBpbv4Rk4DcSD3+9Z
         k0QpusZHCNPCKxDG36xpp+eboSutpa1iMbygSjDwnJofkE1uIUZA3G4UvZwKx12P48Lo
         SRbOgio03zdVGZ74m+y0gBzwv9vpUx4BchJjM/8CkdgRh0eZJeaXU8V4cbz0tKyaWeHR
         bCv35twcpJTbkI4akALS1DvXSVOAHZfpmU0xhAlvPfGYhdPuxtiUYFQw42cdPSIVjJtu
         wcpkHSNuUJ1Ks/qrBHpoFj7Z76Ric92vRZ7YQMMVluMI+Kjpr+MP0YxU5UFv6rYD4kI7
         sLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073583; x=1789678383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mCkJNb+QrKnJKj/QcqFSE5iIzRjiFJzvF62FVz0jZM=;
        b=SBWyz/aP6DbURIFJWZQ5dHUaikH313VmEyM1t5p/tas3MSkDZrvIGHeVSFjVXjh/J/
         +x8LazWy3h2/h2gjNmG63ZPwN7urcZapV3IMoHbCwWONV03Szl8i6I6+xfI1S/apv3CZ
         VvSvsgbXk+ZrX7PZRUoIbzgRc1oRN9bZvGQCYfYDjhisaq+KvdksMov/q+OSr+1axjat
         ZzrgDks2x8GdI/dGvPMZvTBtSXlw1sj8n+NZ70XujIe+OPYyO8OahPlrGi5JYwr3qyw9
         nc2Ax8tDfYLdBFiBTbykE5uqXk4s7G5BmT2dWAvY/HYTBGlMpgDiy/HPTR4mdnJ1tt5y
         Ik3w==
X-Forwarded-Encrypted: i=1; AKwUvBya0qGkcKNHHqNkml8L5CceUsnyXUX2lXAWmIFNSo7aw2gTtn4bri1+kjX1I09tLHRD+1cmXKo=@vger.kernel.org
X-Gm-Message-State: AFuF++m/cspULyqF7qOzf9U1fVFBrkodLk8LAUZBh1n5kxvuF4BLZxzL
	pBTgx4lAGFNOTyZEGc0cT5huHxgYXaCylRwdy5iR+Tc7RHa0laWeyPC7
X-Gm-Gg: AYBFou3FqNaerXl5Ns4xbH8sIlgDEndAVKRaSHCfW6W3TnjWb5/lTtAWQqaid7NOwD1
	Tt9swnDYgh1sGeHAY7A/zS/jZI9/2LxTjiARfhVR52q+euw8Q4X9TIYfHouqkpnNu3Ysv2GSSGB
	ITVJezESZzA8NXYEEp2uUjMRZBVM9qm3Kz1uaMs59VcPAHL93OWvFXQYr2hPpYjVqH+t5m56G3Z
	0bD8/UXNVKotJ5c0ep0+8hnOBKLR1Gzc6P2rVlHaXDl7rTosDMGnUx3zr3d4YcCbO9QBSP0vB5D
	JeR4eSJUi7w4px21t3RHVJABPw1IqkWpqECw8bI7n98/iTKog7v5c73TtgvXqrbbjTNda5D+QPr
	Rm0OXTpIYR3rZzS7BeDmhdC4kyMhd9hELu32LDpw9i46yB9fV3ezLNb6Z9+wXiOWCHNADozEccq
	QnJCC6QStjvkVEc3Nk2ZUghwXflvJ1GaQCi5hrVjE8joAISHpEunvhCrZW9MezyVdl4j86VMAjA
	i2bGXdoZJJgk76SJCASoFxSvHzeNG/q3v3mk92QZXYelEcvKcnJqucPaSQRxf9qYfXqtgXDGxkQ
	i9YqklJQExvBd7yGPypUNqcgBYUAWFYoUjn8uJfjgkh4btnqVlOUpVxvuo3dTpfl0luGc324D/9
	vrrOasL1Cw+vTdenfOnamGA==
X-Received: by 2002:a05:600c:a0b:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49e618863bcmr18595615e9.4.1789073583171;
        Thu, 10 Sep 2026 13:53:03 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b3d9-b901-601c-58ef-b3f5-74f5.310.pool.telefonica.de. [2a02:3100:b3d9:b901:601c:58ef:b3f5:74f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49db038401fsm77237325e9.13.2026.09.10.13.53.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 13:53:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PM: EM: allocate the cpumask for every perf domain
Date: Thu, 10 Sep 2026 22:52:34 +0200
Message-Id: <20260910205234.5392-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

em_create_pd() allocates space for the trailing cpus[] flexible array
only for CPU devices.  A performance domain registered for another
device therefore has no storage for its cpumask.

All performance domains are added to em_pd_list.  The netlink interface
does not distinguish CPU and non-CPU domains when it calls
cpumask_weight() or iterates over pd->cpus.  A request for a non-CPU
domain reads cpumask_size() bytes beyond the allocation and can report
bits from the following memory as CPU attributes.

KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
against a synthetic non-CPU performance domain.

GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
request can reach this path when a GPU or another devfreq device has
registered an energy model.

Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
empty, as required for the documented unused field.

Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/power/energy_model.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index e610cf8e9a06..fd07c564c201 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -439,7 +439,9 @@ static int em_create_pd(struct device *dev, int nr_states,
 
 		cpumask_copy(em_span_cpus(pd), cpus);
 	} else {
-		pd = kzalloc_obj(*pd);
+		/* Readers expect pd->cpus to exist and remain empty. */
+		pd = kzalloc_flex(*pd, cpus,
+				  BITS_TO_LONGS(large_cpumask_bits));
 		if (!pd)
 			return -ENOMEM;
 	}
-- 
2.53.0

