Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB236B901;
	Tue,  1 Sep 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272891; cv=none; b=N5F1Ts421gn2KVUopVdYh/rFFjc0L3u7Kn9S4NUHUlkHKbXOXUQ1LgldMXNVLW7/N1eaghSC89nh8edtQ/GROdvXFS5nuxCV2Xy+loMFrq6NN8UbhKYmGZ8RoVeIG/iIliMFJYYi4e42gVo/3y6BnbLGeJ6bRECWijO7bBHqq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272891; c=relaxed/simple;
	bh=i7lOUejC2tGwB1iXyXMM/XGwV6CJY9bP3bO8Wn1ZS88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux7/AWVCkyx8LGHHjtxSoV5vox5zXmC2GUxTrYRiW8DX5kV93cXK6RzjsCEju0dWq5YNW/il33jVbOHwLc/MgHVa/vkkTuC2qSNq3inP+aLyDHXcijVsEz9/c52kmeJ1uHkIDrpedo2RNPMqVXdKt75hj7ExnRgCrQ9/1g+6IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFVCJCFt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFVCJCFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788272889; x=1819808889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7lOUejC2tGwB1iXyXMM/XGwV6CJY9bP3bO8Wn1ZS88=;
  b=bFVCJCFtNWxI4M6O4BpfCvov5weTghQVcR+Y/KBAKuP03BsX695c8POg
   WLUQo3otMNAnnS5m11EidbNtsrujmFKKjU1ObaUpXsulBVJg+V1W0KC+E
   NvyvaH+fwYHT0ld/SmR+k20dHpyHUGr8bRaP+u+FiLxQdStwcAiYqOpQL
   zE7kF1xdeVpHF54sOH0J40wGjxNWLKbjtgSrgYdFbL9+IGPKlYIvZ/vbW
   yHdJQVpftWkjC9AjokEm/vekmI6f6Xbs56EVjmwaML8jVE09N0rEsIv5m
   LvpUphwD7iqSVu5IkEN9TsU52X7yV4XQld0RulVAOZZi16/qhM+ZirROC
   g==;
X-CSE-ConnectionGUID: cSst1+J5QWiqu0xF5HAAXw==
X-CSE-MsgGUID: 9sTZ74oKReyHDw6SGxDbgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92571264"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="92571264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:28:08 -0700
X-CSE-ConnectionGUID: gzPAOPuqTl+Tq84be+jC9g==
X-CSE-MsgGUID: 72cqK8kGQp6DIKZNbhkLDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="269685089"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:28:06 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921: skip unknown CLC firmware records
Date: Tue,  1 Sep 2026 22:27:57 +0800
Message-ID: <20260901142757.422688-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816174841.1918-1-acharyalaxman8848@gmail.com>
References: <20260816174841.1918-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Aug 2026 23:33:40 +0545, Laxman Acharya Padhya wrote:
> Treat an out-of-range CLC index as newer firmware rather than a
> malformed image. linux-firmware 20260810 ships MT7922 records with
> idx 3, and rejecting them made mt7921e fail to probe.
[...]
> Fixes: 9417c5818a01 ("wifi: mt76: mt7921: validate CLC firmware records")

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

This wants Cc: stable, and it must not reach stable after 9417c5818a01
does. That commit carries Fixes: 23bdc5d8cadf (2022) and is in v7.3-rc1,
so the Fixes-tag scan can pick it for every series with a three-entry
phy->clc[]; there this firmware then fails probe. Those trees today read
the idx 3 record past the array instead (UBSAN at mcu.c:474 on 7.1.12,
https://bugzilla.redhat.com/show_bug.cgi?id=2515420).

Greg: if 9417c5818a01 gets queued, please take the two together.

My Sep 1 patch duplicates this; withdrawn.
