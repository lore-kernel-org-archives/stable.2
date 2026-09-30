Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A123C3F60;
	Wed, 30 Sep 2026 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749669; cv=none; b=mB6p3O+zMz87akAWeSEySNOzrEJHDrCe/XeU1MO1bPYEe+W4s0Db0m+DiTn7eygRJDcS+L5em+OkZb6NsO2nKvKTEthfdxNt33k/TvoWOWFDKmj1wsyErRXiH2p76eGPAgHuxSI90qNjH/lXvhzMc2c0pm04B80T9TGht4Xdec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749669; c=relaxed/simple;
	bh=/3PP4SPVUyVv/tJE5eEBnmm0ZOE0YaDqelzacF/iyEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHmW13wqBxmq0dFt5P3YpGs/ZiCzdzmUbWuGhyIN7ZpbZvLsp4K2kZozv6LEn/GLjI5yd5Ix4GNsyR94vlWGUW5fiFtIWb+abtCjWRofd4hm0pNT8r7juIoDlwXRfxke8utgb6Twx/VYhsmKO9rrFvwehLqZgFgEi2T/NWFEx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M1W7PZ4r; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M1W7PZ4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/3
	PP4SPVUyVv/tJE5eEBnmm0ZOE0YaDqelzacF/iyEM=; b=M1W7PZ4rS2NN9f/I4b
	c0KmgKO/0R4Q4XS9T61JSQ1J/VBgIblgXB7jytb2vkXEQ9C/zMe7PCMsHZ8L3S7R
	mUwYDHOcF8S6AT6/gvs+LBUgSeAUlWM9FGv896ifjYVKH9VgK3k+Tx+BVfuh8ESy
	iFEkLNAnhV/qeyBT1Yz5GFy5o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXP8rCq7xqTpaaBg--.34713S2;
	Wed, 30 Sep 2026 14:27:15 +0800 (CST)
From: "Gongwei Li" <13875017792@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	Hans de Goede <hansg@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix scan-abort timeout in rtw_scan_abort()
Date: Wed, 30 Sep 2026 14:27:08 +0800
Message-Id: <20260930062708.1585771-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026093048-thrive-phoney-5b9e@gregkh>
References: <20260930015024.3627275-1-13875017792@163.com> <2026093048-thrive-phoney-5b9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP8rCq7xqTpaaBg--.34713S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUercfUUUUU
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC-gPkn2q8q8NP9QAA3C

> How was this found and tested?

Every other jiffies_to_msecs() call in this driver passes an elapsed
time (jiffies - x), but this loop hands it the absolute start value,
and the check never passes.

I haven't tested it on real hardware. I don't have an rtl8723bs device.

Thanks,
Gongwei Li

