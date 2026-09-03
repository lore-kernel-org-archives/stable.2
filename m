Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B743802B;
	Thu,  3 Sep 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433502; cv=none; b=bdh6JbA1AyeK/Gpiou9+hU4CLx9QRjv0/y4qUm+7Yqdu+R55muq4lEiv0A9INNZX8vOvk0ckG/Bz0bwoDXOuWg4uASyK9UyqOCCVSYGCrCGHCjH+xvxaH7nMnt+5NpbGmotuHPGc3QXuwpO/AGd+K9u35Eb4EbxmnDAAHghxiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433502; c=relaxed/simple;
	bh=fjTgsBxrgzCHCQ91O9VNEkGJ05DbXsonzo80saT7PMk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YCbRibP+aH5B4DWzVCMP0Zm0Tr7fK2AUpySbPMAW4i9T3qO72UYF0sTHJ1dW23fogSHo8uvfADoIfdw9d6APMgvFEkNNRbtv/sMxBwWNWyS/jbuW0VgxXzlD8pbgd3VmdabxJEgSU0Pi1yf/GjAbVx1pmzxGY9RSgRyw0/kvKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFCkdzTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFCkdzTr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1BFAC2BCB8;
	Thu,  3 Sep 2026 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788433501;
	bh=fjTgsBxrgzCHCQ91O9VNEkGJ05DbXsonzo80saT7PMk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mFCkdzTrcSdmyR5iKFV9USwemu8vEWao1HKaZnWhteT7j1xIV+9/XxudH48leb4mI
	 XZYQNIYqz0eHJTY9n6W3YOn4m17F2EQyLuVzPdH0AxAKuaCmL34qOijSpshpJiy/0j
	 1LHN3pl6/h6Tu5Ddb1DGVOt9KavphcTzoTYe2hCyfRAI4fBVF4rnDrPkhuJsNVMWue
	 4ANp1YqHymwKE/IYqbmj7yeAQci39dnOownBdkvsEvrsIo98fRWCoPhTWKUiPVZv5E
	 +eYNkkVQmpvuCe+G29W/mmS5iCySQi8OZ1Gr5NaJscB3PdC/x40MyO53YSQxDxVzjN
	 V0MD3cyAUVTjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95839C624A4;
	Thu,  3 Sep 2026 11:05:01 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] perf evsel: Validate cross-endian samples before
 byte swapping
Date: Thu, 03 Sep 2026 04:04:19 -0700
Message-Id: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxbSEVX3sOwKGWAMdCSFiqEc
 HcBL+DyJe+/v7KAnjCwR7Iyj5ECObuDvCTMtNo2CFTtzCSXit95CmHph4+Fjuw0A+cSarK6gyg
 BU67zqpaCG8H2/eCxpvlsv4ofh6l8oxmP4GG0FEbnl/M8isP75ycKEHAzCjOhVJmL7Nn0mrqrc
 T0rtm37AtTpQTXUAAAA
X-Change-ID: 20260903-sympwn-linux-002-final-v2-e30a8df210c1
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Mark Amirkan <markdamirkan@gmail.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788433501; l=1879;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=fjTgsBxrgzCHCQ91O9VNEkGJ05DbXsonzo80saT7PMk=;
 b=GpM47J3aBt0a9DqS1ASyqN8OypFVI95A2mbLkewsLzx9dio0alYw/4LnMDxNyc4d1utR2ynbE
 4YbH83CSykhD+DCIwF8V3HDNEeN8uHKdr7err1DcrwNpeaezl8hTpYq
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

Two paths in __evsel__parse_sample() use values from an
opposite-endian perf.data record to modify the record before checking that
the data fits within event->header.size.

Patch 1 checks the complete branch stack before swapping entry flags.
Patch 2 checks the RAW payload and the complete 64-bit words touched by
mem_bswap_64() before swapping the data.

The malformed branch-stack and RAW records reproduce as out-of-bounds
reads and writes. Each patch adds a Sample parsing regression test that
checks rejected records do not modify data past the declared event.

Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
Changes in v2:
- Add the adjacent PERF_SAMPLE_RAW fix found during v1 review.
- Keep the branch-stack fix unchanged.
- Link to v1: https://patch.msgid.link/20260903-sympwn-linux-002-final-v2-v1-1-7c6e4166b814@gmail.com

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Mark Amirkan (2):
      perf evsel: Validate branch stack before byte swapping
      perf evsel: Validate RAW sample before byte swapping

 tools/perf/tests/sample-parsing.c | 109 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c           |  20 +++----
 2 files changed, 120 insertions(+), 9 deletions(-)
---
base-commit: aadea57f532882d8bab444646863c7ef8a778ff1
change-id: 20260903-sympwn-linux-002-final-v2-e30a8df210c1

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


