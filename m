Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686295;
	b=4n97YAV5QHsMuv5SXUP6nLuefnDS6V5VTJbhgkUJfOjs3Tdtod388dugzsqxnTgKAcx8
	 FNT2hm6rTRCTGP+LdJVls8D6Gp10KOJE9OkHvv/cLZp1JY68eFAcB+KKQyyA8yxyjLZ9q
	 d2/67/ZwxQdo4hFO8Avrz3gT45NKG1z+qaECD4SwVFsQVu3V4acChyVgCuJlpCHzJByv5
	 gFay6GkHPH+cMOEvDK4OvSfsRsMmcZwWXRh2fI76lSNJ/lrhscAlZHYaFVkjlUGUomfCO
	 AFMLSgWQXfUfqtYLPzfUdlB95NxgaFolOgz+X9AEpV52YOcnapt5Ar8SDBMhwWZvrEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686295;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9tXmhQkuf+p461M69vTwgg+lluCKw6UL5bselaHaJEw=;
	b=P6FQYxINU7+ixS6cxmu1aqErrRim/OFMO8cE0RvOIHNPh3G7LjocOMhFRIgytSau+c2a
	 Z9YaJlsmyaFitanZ/x6kxr2L9oXxlNXe0XQQSzbOq0rofutbfLrcFb0lFkkh71BRVrBnN
	 lTz5L7R7hRDj2TSNbO5tBK6jqo3nuPzKhTycAU9UpJdV3Ch4yGOFQ8SeLH7rnU4OqUXae
	 q3sDhuDrbmyv9aytQvkgd7A1ShzfkP9swDY+JPUil+0HwNuzayfKoMfORfhkEgB+Qqw3d
	 D+k7gvGm4/vOqjay6T52wgzF/ECemdceK9DJLfiufGN4kdlzto9INKXGjmDBLLWaFlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MU6Dbjdj;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99120606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99120606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MU6Dbjdj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795686295; x=1827222295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y3hSz2dK7H5UJZ0ekMVX9oPCGw3hg2Sw+JW0JWgjTbY=;
  b=MU6DbjdjjA2E7keWhZ/ZVZI7qLNJAKrn1NaJa5Vm+y7TOKoLYUE8r4D4
   AE3uOavYJRoGQgvULtckhfLERu632cddwOifdlPS6QKI98SCDoyfSmJsH
   Qo44FmFLVlco7gvT1uIgazpKTBYKp9r/QTlikaS5O+ae+5i2HhKW9o8Iq
   u423Z8xoox8Ypcnq+kOcgiwr5rh9TyP0Syr/TQOVPWImh9AFvKKI9Xd+G
   ignfIGnLwshUNzxoj8RjETSJjvGujuNElmm8vB0nGW67IdxrLBe6j+jn+
   7pR7vyBKZYfcZBfM8M7IWvrGdSD7QuoKiOtyTEzBs6ybh2nW5ZcFprVa9
   A==;
X-CSE-ConnectionGUID: qTXD3LVITDGPi0sDqltpsA==
X-CSE-MsgGUID: Mc5diyUtTlekhNTUqLTBNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4604824"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4604824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 01:44:54 -0800
X-CSE-ConnectionGUID: z/FPr4q2TjOArQtZi3xnKQ==
X-CSE-MsgGUID: TfgPabtuTVKX16QOHGaaHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12453854"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 01:44:52 -0800
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.william.auld@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH] drm/i915: Reject relocation writes to RO userptr
Date: Thu, 26 Nov 2026 11:44:44 +0200
Message-ID: <20261126094444.52858-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.56.1
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

Read-only userptr BOs shouldn't be allowed to have relocation
addresses written back to them. Enforce that.

The relocation slow path where this could have happened has been
in place, reverted and then re-introduced. GPU relocations path
protected against this via ppGTT flags was also reverted at point.

There's no legimate use-case for this, so instead of trying to track
which kernel versions were impacted and which not, just outright
reject with EFAULT on all kernels with RO userptr support.

Reported-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Fixes: 0b100760e3e8 ("drm/i915/userptr: Enable read-only support on gen8+")
Cc: <stable@vger.kernel.org> # v4.19+
Cc: Matthew Auld <matthew.william.auld@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index c41e1b9a40bc..7ed23dc392b8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -511,6 +511,10 @@ eb_validate_vma(struct i915_execbuffer *eb,
 	if (unlikely(entry->flags & eb->invalid_flags))
 		return -EINVAL;
 
+	if (unlikely(i915_gem_object_is_readonly(vma->obj) &&
+		     entry->relocation_count))
+		return -EFAULT;
+
 	if (unlikely(entry->alignment &&
 		     !is_power_of_2_u64(entry->alignment)))
 		return -EINVAL;
-- 
2.56.1

