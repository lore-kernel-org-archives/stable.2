Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CF30EF92;
	Sun, 11 Oct 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758042; cv=none; b=fGERmMoMaOAjS7BW8wSjT0kYdF2SoazVqILzCYu4AKJ6bj1tZu/Q0c8E4CG4PR2LCpzeGrf/oFz7ahOni/IZEobYYxm7iwy0gNxaONof0moH5cIktzpRRXkpF3613+agkP0JKvNjFf81oYFivHo79vcJZ6CmQJYVPlYY5hhf6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758042; c=relaxed/simple;
	bh=2y2iKPg/B4HpaRYkdLSUuoKXxSaj6YDR6XISgM7xkEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcEegL9L1BTTXC5UySQaMNl6AMVGHRj2Fyrm2+dKfvrrKTABIR/26No4GJo9IVdq2h+s5jqmCysZIGAH4FSh0iFOPjNz8kGwZ2A2KhzEaQsihmtLRwlyQWK8fEkRiFFXBGaNoLH1t7bwNfVfNGmBpu/nVZAWdkymw/AmM7RH/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SahM3zMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SahM3zMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACE21F0089B;
	Sun, 11 Oct 2026 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758041;
	bh=AcQCjogWA01rdX8n8VEfQujs+iCRuq/eyTLy/pGYwG8=;
	h=From:To:Cc:Subject:Date;
	b=SahM3zMhAIbXAmVSevQgdk+neUZyroRE8A22V3RsElX+w0JycbJp3p+zKFk2SBgOz
	 HURq4KJp7QHL4C3ss8AF0seBjX17l5DU+gEnmo740YS958O6JrqSvhmDQimewEVBgD
	 yhf+emtbMz7puhSfeSzfab6PwO+nvPeMWtCEsiUppDh8ap7JnXeV+Ubzutc1sZgihA
	 RqKJsCdpQp+uR40R+kBr5ZCfpxddbIwcaHR0rtrsO2ALRt0up1SFy8gIXwtAnOdOhZ
	 IIc2P2aBqYx5btpEzCmaK4eyDG9b/PCGBe9/Y6HDa+c+SEY+DGiVTulgH33VqcRTk5
	 kg9flcPFBYXYw==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: keep O= builds inside the cpupower output directory
Date: Sun, 11 Oct 2026 18:33:29 -0400
Message-ID: <20261011223358.2327625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/Makefile builds cpupower with O= set to the top of the output
tree and subdir= set to tools/power/cpupower, like the other tools it
descends into. cpupower ignores subdir and puts its objects straight
into $(O). Through the kernel's "make O=<dir> tools/cpupower" that is
the kernel object tree, and "make O=<dir> tools/cpupower_clean" (also
part of "make tools/clean") then runs

  find $(O) -name '*.[oas]' | xargs rm -f

over the whole kernel object tree, deleting every kernel object file.

Append subdir to the output directory, as tools/scripts/Makefile.include
does for the other tools. Builds that pass O= without subdir, including
"make -C tools/power/cpupower O=<dir>", are unchanged.

Fixes: bf35182ffcd00 ("tools: Honour the O= flag when tool build called from a higher Makefile")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index ab428e336d878..206de09252a57 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -10,7 +10,7 @@
 #
 OUTPUT=./
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/
+	OUTPUT := $(O)/$(if $(subdir),$(subdir)/)
 endif
 
 ifneq ($(OUTPUT),)
-- 
2.53.0

