Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5130E85D
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784521; cv=none; b=JirPV6RfgF10blezn365Vss8h5hQlt2h66F/RkMLDqmw1ALH/3/ZbynZvRBvq0H2BJwY3PGmCY0fiIUn7LXaduaAn74LbvQvfiioturp684URVf/ReZK4ZPVDIy5Dk/9LIocAks9bUsFjCkIYyOFSDh/FjOmhc+CWrqopmcb2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784521; c=relaxed/simple;
	bh=4h/PUBUV4AuDWrQ4qEuJPddJruaJRjGlnrLMgur4U1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNAJRTxiJEUPCRnDUc/SqxB2/rux8uuTJtrg80g7DQ9xJfaFsCJ1IMZlF6YdkblvppsUv9Ztf31ogLNqqHlI3GO5Kbt/4lTHLiseeNqmEubEwbfkNvgzBUuxCEERUhvW1hJW0zL2dEqA2AfvaWV42sJL12z+tlHLOa1eLa1kUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hssI7nnh; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hssI7nnh"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4h/PUBUV4AuDWrQ4qEuJPddJruaJRjGlnrLMgur4U1Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786784516; v=1; x=1787389316;
 b=hssI7nnhsJ+sqi52RpDWF6/Lhssu8joFDWVVeOmZ+i13Wq/4cszcfkbmQER0nwr0xOAeQlVI
 eu2GkAHl5LeN5OC2fwjmqAXaZOepEYmITtarAIkY+tkJP1Gqo1ivWbFHqFNqtETuu1+lJ2+8hTW
 LNy8ZuEXxh/xUG5bs0TRSItk=
X-Envelope-To: stable@vger.kernel.org
Received: from fedora.fritz.box (62.216.208.217)
	by mta10.migadu.com with ESMTPS id 61ce3dde4468f97f;
	Sat, 15 Aug 2026 09:01:46 +0000
X-Migadu-Flow: FLOW_OUT
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <ynorov@nvidia.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Reject invalid window_size values
Date: Sat, 15 Aug 2026 11:01:34 +0200
Message-ID: <20260815090136.88540-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=thorsten.blum@linux.dev; h=from:subject; bh=4h/PUBUV4AuDWrQ4qEuJPddJruaJRjGlnrLMgur4U1Q=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkNWh++z7G9Y7rwnUHUDTbBWPWd26u/qVooyIhJnzu/e Y1hcEx6RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEwkm5WRYfoSu5sCy5j0Fz/Z Mnm66hs+cf8zAscWWoU1ss2cfCXHcznDP5PdOtN8llRYNS5iL2uPevTjlslCiU8/n24WNPjF889 IkhMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

window_size_set() sets ret to -EINVAL if new_window_size is outside the
valid range, but then falls through and still updates window_size to the
clamped value.

Return -EINVAL immediately and do not update window_size. Also drop the
now-redundant clamp() call.

Fixes: d6d71ee4a14a ("PM: Introduce Intel PowerClamp Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/intel/intel_powerclamp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..8026651133d5 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -289,9 +289,10 @@ static int window_size_set(const char *arg, const struct kernel_param *kp)
 		pr_err("Out of recommended window size %lu, between 2-10\n",
 			new_window_size);
 		ret = -EINVAL;
+		goto exit_win;
 	}
 
-	window_size = clamp(new_window_size, 2ul, 10ul);
+	window_size = new_window_size;
 	smp_mb();
 
 exit_win:
