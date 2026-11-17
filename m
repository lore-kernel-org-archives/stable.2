Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925556;
	b=X90i6ORftIM3veCeD36MsCmy2OeX0SqvJxMYlJxs9OYD2GqigHCE713moikUV5M04Hh5
	 m7KJate5k8LkANXrb9dvZ4K2EkbL1wV6LimULdAkEDRxk33uHzomHPQBtzLcB3e3yjFYb
	 cQdiclZWZw3Yj44bp5itQmW6Lijx7DLPfD+WpDAf7H9G/XgtOpR5ZNs3dBVz9wreL6Ax2
	 CpN0kvoPe7FqLfnqotqFyJEngn0qlMr9YI77hAa2RpRscfG/cNVFW/iRC5uC1JO/WLcat
	 /s7qJQvB5190G9OlX6E9iXvC/TtGKF3pMCscX1fBi2fR5uOPClyD9UCWuhDXvf6Mg+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
	b=NB95WkInBhS6SmuruY2Ikh3J3JlCEncfmgho8jI2U5ONU9pqQP1HtxeYzrgCkP6y1DaW
	 S3i//tR+NlRJF+KM8mb8EgbJuDqbhQ40jqUl/icMUB0/UucEt35YFtOli7F0+xIBGNSrL
	 jnqGy7qIUp8bvDF6qz1xdn/azDetMKqlnSSdDO6kmWMfjAwIUo9Uy/zYfxU3dtkv1PT4Y
	 fABrgr1xNDb1W7yKj5+DGAo+cPAYRkTD/A9yIZ1ADB6mbTZ3Yhpd/UUHhdaeKW26lEPbX
	 qgycEQDLFRnikILc8KT01WjdW10tamZVlpq6/FblFr48bR5jpVek/nYhwGPv4MQ50yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjZj2Wvh;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFB606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36CFB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mjZj2Wvh
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-70b875f6f1fso4819248eaf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925555; x=1795530355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=mjZj2Wvhjog8aodOeIvpWtVJoReEW/rQXMk51ee9WBi+rUO6vOcSUYfWHVY0CJV5xl
         IB6Xv7Bz7J8LtKr+Uyzc1EmzHQn8PvPzLAQk84NyTmVmNzzplhO7WcRqHGtew5lqZx0f
         VU5G0NpVqsE4IwcNG6JAmJpGnJvnI7tVR0nnCIEYrQnXhxRJU1yuTESAQ4XXcpXvRSka
         keLtcQw/UA+RFkxFeerXWnjTyemXZMI5WADUU/1O9ec5066n/DK/jFyM54oCeF78CePs
         T+5anJL/92y8GVKAe+eEFyEdukIgCXJGYTY3JP157/bT8uXo8JjPSmpYF+821GaYybo6
         1jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925555; x=1795530355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=R56dQK9Ch0Vpq+6KDfrwAoTH6WJAwgDd7ibptruPm+Mgw0nng6Q6HSCJMVqnuc+D1S
         8bh5M9msvQA2ILdikaQ+jNU4fmVbv3j2pzzlBgPXBj7K+K007DcHitE4V9x9N5Kh2eJd
         XraQLr52BkOeckEbTSCqhdcid/BL80BTb93QMHM1813Tx2Fs7LUMqxUUdBIgoLeqrO1K
         qgWDnaXprsmSgawY27+O7gmIIfTjpZexxhPIrQaAxdQLmolVZPE5foOIChRKLG8drtBV
         4QYysilYk0Br/+xp1bvXKbB5Ue3oOHYy6tBEa0OxQZRnUpXTiHl+Twi5TxmAPqaYNxup
         hoNA==
X-Forwarded-Encrypted: i=1; AL+hErEiFwkBbBq/c4isYRTgsxN763dDfPXWLE4Epx1NpSgY29RF20B+YaStVaRl5LwftII2za37ehE=@vger.kernel.org
X-Gm-Message-State: APuU4Z88bHbPsCR2Yu2/MmlBN3tLUa63GB3y1SlYV7eHnBHBJ/3sYwGR
	s4B5mZcK51FzEsGmHUFenC9qa53Q60GT1+w0o7r/oFQPtLpeKbIztPQR
X-Gm-Gg: AYBFou3Ypdf5tyuBHST8/heiLPYjueZLO1lGgYdtILvgreqAcKOARJtfJn2JRvhULAG
	TzKuGzNeuRO8rblT4hPbABB9lTbK8aWMMtXp1q/VIzeqnn1+N5/NUTuSOpVjtlOq2mrHX+ies5v
	vWE9FQHXlIOwmXdYG/cVI3wNWKDT1ujlykpsa5ZKQvNaQ9YzPWHqe33aiIAP4UUSt+uIAxmm1Eq
	SmvqvKSq1h98dysklG9T84OGkQ1GYWZWlcmDu+QvUsnJzAZa6rmKmiNZ1Gz88lUZQZtty9GZXpv
	v5nPIdYWSdzVlPnA/k7veAuUhQFdFhXcaZHGYNgLbB+S4JbE5196g1VnjJLlvMYi7qFnQFyeL6Q
	QWQR5CMQ4LkiKC3CB0pzSWAlwWQxp5ROa/Exd1+KP2I7N0Pcs18mM4LanAyx9ejOoDPbtM/Fm9Y
	oAEGTkGcXf6/7/zRKS8rWTgZ6r0beCDjKvt9zSTj/Ri7Ga8FuM5eoKePCJypcPHmMnzv4a/Uw4n
	eeFZSJAB+y+8kYb3dl0RoHVa86gbsJtpcb0JYAt4x6jTYQbNxwY5ejvxPBwigCem3iBVHyUzIWX
	XwPDX9W4tT/uyBT5ckjl21tBfuVRdsGiYWM=
X-Received: by 2002:a05:6820:1353:b0:719:1ad8:a34a with SMTP id 006d021491bc7-71ab51ad506mr8840255eaf.67.1794925555161;
        Tue, 17 Nov 2026 06:25:55 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:54 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Tue, 17 Nov 2026 19:55:20 +0530
Message-Id: <f26a80d822ddfceb926aa732deb96e81c40dd2f9.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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

kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
perf_pmu_register() fails we return without freeing them.

Call kvmppc_cleanup_hostwide() on that error path.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index a58634f656e9..ec05b4855736 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)

 		/* Register the pmu */
 		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
-		if (rc)
+		if (rc) {
+			kvmppc_cleanup_hostwide();
 			goto out;
+		}

 		pr_info("Registered kvm-hv pmu");
 	}
--
2.39.5

