Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000947CC6F;
	Fri, 18 Sep 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759214; cv=none; b=Xe0b3X75WisVzu0EZFjIBKFJjY07P+JX0kkDbuAN2W9M1Laa3WkrfuDpQhOOQS/biGCaJLGnHiBp9Be6mIfwcG9YbTlT0+52dCzNg34eZ4k87IulvSqXYs450YRopsG++ny9UXBeQDg3zVcr8WlZiJgNCwZyHRVaA7UpWslDMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759214; c=relaxed/simple;
	bh=wyR7tDwGJcqIcgmBM+MMn+Ss9unScCWQlLCpyOrSdRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daXZxCX+DCcN8BFUQOH/PWqlq51se7cHPrucZP0w9Pxfjf9Y/iYIfBSfrhlv/ud2TYHANwQfL7T9xu657mfp++fY0ovzWybqDbeVFifUAt881R/umbJdsUtLGJ/3ytXMRlPLmA2kh8/OufD4JFI2rfGizyBtWCBg1laTUCNu1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=S36cJkBT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="S36cJkBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WGy/w99RgFFH0BgQXIibBFWxvu+YAccLW9hQJQLUIQU=; b=S36cJkBTrhdlH5QRn1ezqEr9GC
	9HKp3viWEpLw+dLc23GGna0M7fGOleMzC4vy0AoRygPqXz3irQUiI8ChP+cJUq7YsM4nJMCF6ajMP
	yoEARAThqLt4VLoHcXbNGbxfFrzE+BMZMGpd5cjPfr7SqGTlX2xfS68i/k1Cthw037GwyrwRi6KtP
	lsHVss1hnzdA8ZDovPPtk/7/mPrrx2Hmh2S6/AOXPnvCzAKplX46ktgbIJXk26uWe1HIexvE2HNXv
	WtcNCehV+hN+xnE02KZteyHGzxZxIef16mP7fZ4J3vSM3m5jSOS5QJf11YA43ETI7LHaDCcF/pw9D
	RZbG/yWg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1x7e7w-0006Sz-2c;
	Fri, 18 Sep 2026 19:20:04 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7C193BE2EED; Fri, 18 Sep 2026 21:20:03 +0200 (CEST)
Date: Fri, 18 Sep 2026 21:20:03 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: Please backport subset of 2f5d370dec3f ("perf test: Change all
 remaining #!/bin/sh to #!/bin/bash") for stat_bpf_counters.sh script to
 v6.12.y and older
Message-ID: <aq2O42fwBRdHELBC@eldamar.lan>
References: <aq2MQLKmyrxkFd0Y@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq2MQLKmyrxkFd0Y@eldamar.lan>
X-Debian-User: carnil

Hi,

On Fri, Sep 18, 2026 at 09:08:48PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> Recently for v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52 and
> v7.2.6, the commit b02027776ac5 ("perf tests: Fix flakiness in BPF
> counters test on hybrid systems") was backported, but it introduced
> bash specific syntax.  For versions after 2f5d370dec3f ("perf test:
> Change all remaining #!/bin/sh to #!/bin/bash") aka before v6.17-rc1
> this is not a problem.
> 
> The proposed patch is a stable series backports specific one, as one
> cannot simply backport 2f5d370dec3f ("perf test: Change all remaining
> #!/bin/sh to #!/bin/bash") without picking as well some other context
> related changes to make it possible. So I was proposing to only change
> shebang to #!/bin/bash in stable series were it is a problem, as in
> the stat_bpf_counters.sh script.

"Obviously" there was a typo in the commit message and a missing
explanation, thus v2 of the proposed change as follows.

Regards,
Salvatore

From 804ae26dab32c846467d7b7887d8f7dcd3348fa5 Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Fri, 18 Sep 2026 20:48:59 +0200
Subject: [PATCH] perf tests: Change shebang for stat_bpf_counters.sh to
 #!/bin/bash

When commit b02027776ac5 ("perf tests: Fix flakiness in BPF counters
test on hybrid systems") was backported to several stable series
(v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52, v7.2.6) it
introduced specific bash syntax. For versions after 2f5d370dec3f ("perf
test: Change all remaining #!/bin/sh to #!/bin/bash") in v6.17-rc1 this
is not a problem as the shebang was already changed to #!/bin/bash. For
the older stable series this introduced invalid syntax if #!/bin/sh is
not bash:

	$ sh -n tools/perf/tests/shell/stat_bpf_counters.sh
	tools/perf/tests/shell/stat_bpf_counters.sh: 12: Syntax error: "(" unexpected

	$ checkbashism tools/perf/tests/shell/stat_bpf_counters.sh
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 52 (bash arrays, ${name[0|*|@]}):
		base_instructions=$(perf stat --no-big-num -e instructions:u -- "${workload[@]}" 2>&1 | \
					awk -v i=0 -v c=0 '/instructions/ { \
						if ($1 != "<not") { i++; c += $1 } \
					} END { if (i > 0) printf "%.0f", c; else print "<not" }')
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 57 (bash arrays, ${name[0|*|@]}):
		bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions:u \
					-- "${workload[@]}"  2>&1 | \
					awk -v i=0 -v c=0 '/instructions/ { \
						if ($1 != "<not") { i++; c += $1 } \
					} END { if (i > 0) printf "%.0f", c; else print "<not" }')
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 68 (bash arrays, ${name[0|*|@]}):
		stat_output=$(perf stat --no-big-num \
			-e instructions/name=base_instructions/u,instructions/name=bpf_instructions/bu \
			-- "${workload[@]}" 2>&1)

Change shebang for the stat_bpf_counters.sh script to #!/bin/bash.

No upstream commit exists for this change as for versions post 6.17-rc1
the scripts were converted to #!/bin/bash already.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
v2:
  - Fixed a typo in commit message: hanged -> changed
  - Explicit state to what shebang was changed for stat_bpf_counters.sh
    script.

 tools/perf/tests/shell/stat_bpf_counters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 76d4a7f15a43..c4f71bfc0fc6 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat --bpf-counters test
 # SPDX-License-Identifier: GPL-2.0
 
-- 
2.55.0

