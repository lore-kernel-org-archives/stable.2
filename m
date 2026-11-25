Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605995;
	b=XaGe/QCcY7L3KfeZVD2GJFir2IwyOpX6Zv8BT9yRfFBebjVIP9Om2x6r0WZ32ZC89EA/
	 l9k3fSWPikr7QpHxxJHbpANB0byoTzrNykuH9thTp87lAaf4cF5j1gKzahO8YUfw7eLOo
	 ShO7s9l1jDh8vmoafnxO8/fjuCWihQ/GGw3YWo1zqaUnlfLKnAXXExtmZjUcEP5f53+SE
	 bPxzeXDLFBv8wCY0G1rjRqz8+jJsYyA9dTwnq5Qa87dvUNSoF/mt+An3fFA+1g6LB9WwD
	 UThvnx2HNDqO03Pc1Iga/caN1fS8YRML8atKfWjMy9rsEf8A3mlUixTVo7davnfpkuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
	b=qpIkYdI9JMj2F9CqTMv4H3G4GOYjPIHHH2CeFzO+TfQzApBBaNyphw7v2M8cp7JUa6g/
	 SbK2lF7qXB4bAfIQB6NATyMNxY/LbSeLq7LxplflbGxV7Ou4sE7GbVUzwelneKS9O6uz3
	 5/DTjxGLPpTghU3F7Db4PwOzsEJ6Mi58ODlVOlPORMu62B9hL4zRfCca5CHex92/f2Cc7
	 wP1I5sHRWCd2OFuRpPgncUuGmEPdJNWSvVM5Yhc8iyROQpeMmGY9Hwts7m7F983UbunZm
	 CzCLomLJwBDWuPLiTXtUJjYGN7/CODjvJBZFil7COXgk1AgbNp4J1kVkAstkXyKczHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKTJIcj7;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39D60A2608
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF39D60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKTJIcj7
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385c497bf94so2470888eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605994; x=1796210794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
        b=GKTJIcj73MSRc19WpgkJbHmsS4u+4Tpwr7Uylx2HDb9gBLQ3yYKKDWfDoUz+qjBh17
         l+f1UW181QgUoSuZPVNP+wCWw4Tyx96GhUAl443Ha1d87gqeV9osLo+EkhfFnQopmzIN
         moffBKvOT2BONJD27Zg0v8t9eti06H/7n12UYIf2u+uWHI0qHROIOukxS72eTSAxE3ML
         UbHJSo8737BMbGyiI8ciSkn035J2Xr3W5L/3+unJGNC1nzeWLqWtBI5yy8BBthR+36rl
         34dRXp2VABuVWP0rYjgMhTOwRuEuia4ylhWF2zsK+SVwyxNGq4UCujKdyKJM7iQOwA0u
         xVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605994; x=1796210794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDad+1Q3j6dYRY0ykgld/Vjl2b9srpFqahkLGtGJZw0=;
        b=GAGdrydbF7ENsDRhTvUr+fTZWoeCA2yUw9Ixe5fontuyw5IrlKAJxjcdeG5gbdKWdC
         rDocT7A55f6q/19JSPGDIQFdd/4cTFBNX1dc93e0zeiiKBYJTj/9hLC29vN3bPHLBKLF
         P4E6LAyov2yyg+oGoYBp6V9yy3HDrfw8wWkSWaKR6D27UOfKc0WaIXylkUZPHnGkTwM2
         UQOAk6Xqn1uIcLVGXvTVlo4ypBo5eMp4tjhj/OxtOql2ZQFeqc//tV+ijMrF1J0aRY9a
         iXUK4iSQUWX0KZcr170OKZE/9W0Qfl1vmQyRIup+NPHqBx9nuwOkFEgofY6VhmzKhJRw
         0AbQ==
X-Forwarded-Encrypted: i=1; AL+hErHUTc6GTiDD6cwUdC55qr+VoMa/wVAlur913un6gb7tFuKUY8ORqOpRAPtFUw/9hXNgTR/P8/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mON1QeRmU8U6/Vt0/a7MZ33aVBK3vaZEW6F0Ymo3n9z/rLS89
	5Y7psTM1KpZEMHvyjATh1EB7dPKx+/eU85m4y5pPyZNoHSvdPH371aQi
X-Gm-Gg: AZFdTZfMzgGXhHoKPkS2yP81X8JNj1YRDDa9gnrdD+Zy06tOkQLzOAkmv3Hw4FuGyQ7
	yMGdn4VCegQiwfeZo9rzAOthHF74PcMIH/vo7lfz2sSyHX0QlOXj6maFtlLWwDNa7fYNDwbinhK
	XX9h9+FvPDqql7KFBsxwsU91WWwYv4H6WTcG2H2LGAnOamKn6GeZyf9xiQxTjpHBJ6lHdQj41hn
	2FIwwPEBpC9KNgIoMwCq20ty5Lkae4tStuJVgyQ8tpTvV9BpNyLoxtyko1eGAYFNPk954rrlpEd
	uMWxIDlKZsOyIQPjT1PnwjGDY9MOzO337Kg3wqg8QOvWCvrif/I+VDG5fVeEra+Si+BnEY03eGf
	uyjgOrdIu+g4kyh+/k2gRZ7wVZuJCxmLgcfdQdmrH5zGwvLFYOQj76MKYK6y9S45yT2VAhrHdCn
	fbSd670ICoazq3uGAfZEZtyH/zLFHLHSfJ8A2rDI5Ug+bkcRoIFsbQpZNpVYt3xu0ZBZZN9DAdy
	wPHdWNAgAKoAWwnA8Ge5uHudrUt2oiKvgRZMJeF0Z/sSdPWmKFFtxuz1ror5BiPSkJIFEDGxBKF
	TM23FWrSQ2NrAEM3haLAMhOjcT10FkfYDw==
X-Received: by 2002:a05:7301:700a:b0:384:988d:6ec2 with SMTP id 5a478bee46e88-3856f6524acmr19373422eec.33.1795605993905;
        Wed, 25 Nov 2026 03:26:33 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:33 -0800 (PST)
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
Subject: [PATCHv4 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Wed, 25 Nov 2026 16:56:06 +0530
Message-Id: <158060809f1d4d3708693a6cf33d40365c3af2e8.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
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

