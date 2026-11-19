Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099364;
	b=sq/Kl2OWbYrML4iXHtkpXnZvhuqLyrlVsZSFGoBW1x62obm1lIu7XFAaNUp2AZa9XZdB
	 TeqpalsVBw/jpx160WW8nLRD3Go64rM61lRFMy1bJL/r2htV8vKd34lg7MOTju2DM7VhO
	 3NMom2LNxCyh6OIm/LSVUFBa/4hLfxgRzS84wO5yMAFBWsFOYi5d/9Uf7MfmZLljlHq+a
	 cz9GmKDjtXmrIQXgU1gfYLJzh0sixtIanGrbZ5q9cTF/po4FBcmegMkYF2ANB/WeTNwJF
	 rlkHCmRYqc+AGWIkc2bnn4a4Hs4g06hv/YEAOp9C2I5TlZDY+YEhnXQv3lgjXCIZLtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099364;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=nKxXDuhF3pTpVRKpgVqQ7/Npl9Dmc6H1uiGsSU//6H8=;
	b=43A3j/2jxa7qbN3n95fUjbP0Whv17DQWSJmtdXJeL6kS9tCNBk58iUUb5NShq3wFm+MJ
	 bXlUlD96uODeU/DIG0GRIXmAMUHbV4W/YasO5EMCOOq1YZW9lm3C0ohHer0tyhrcDSbzV
	 3H+yxixf9P5bgJZhAgEfLVZqzymxPiemLn8dIpgxJgkBi+QkEQUsDvhKiKeuVPpt7BgvL
	 cl6m2C9R+/KewO2p1mL/WpaGEfqakY53ZNM9CJ7OH8RVbFB5BVWVsyapSIMcbajCVoyYF
	 VK/e/hlXHpit/TKbF6+Beka9h5zJf23DNFOEMqCrxoXDfT6d50A3qV8P7oyvvFW3L2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KeC9SHQF;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4B606A32A;
	Thu, 19 Nov 2026 14:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD4B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KeC9SHQF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795099364; x=1826635364;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=56xMUlysQLJ4HWXCiqAmCElGj/aPvivcXX4SoVmK8sE=;
  b=KeC9SHQFwN1PK38W7iuVCc9sK2FsXk31hlzfTBMdc5kji8iac7z48qn4
   +g6Eh0ILvgT8mwZkaAtJ2mMQz68lu89rPdNUtVe6qi2BRw+LLarjTUcpG
   QKD9BxTSA4CJwhyMQFiHOrTQnHpQNqdX3bDcKwp6zmgSig8ru3lt8LaQZ
   J5+lpSff9yBwujAS0s0mHjeY4Tm9ZvwtAHy7yroXnaoKUoMe6sPhW82fi
   cpx/aYrjjilhBt/05IMTCB4zZvHavoWfHOMmMfNayWKXusSxHENMvjvWL
   e30K/5OKeOLMdI4HKen1XDHYWBCsOS84I62QAm6ULqnmc1id7hPQA5zPY
   g==;
X-CSE-ConnectionGUID: nbgrDKYFS2u7nYlb/U/6CA==
X-CSE-MsgGUID: oDPSYTqYSjqBRyW7Om2lFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3849562"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3849562"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:42:42 -0800
X-CSE-ConnectionGUID: 8hjqM/KARk67DZ7PP2ZNug==
X-CSE-MsgGUID: 8UQHJDswSN+V3mAgImdYKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10786333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 06:42:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ikepanhc@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Rong Zhang <i@rong.moe>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Fix unexpected
 charge_types on probe
Message-Id: <179509935205.9442.4946497290520941124.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:42:32 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sun, 18 Oct 2026 07:16:17 +0800, Rong Zhang wrote:

> It was reported [1] that some unfortunate combinations of BIOS and
> Lenovo utilities (e.g., Legion Go 2 + Legion Space) may enable Rapid
> Charge and Conservation Mode at the same time, which is very out of
> sepc.
> 
> If both are enabled during a previous Windows boot, ideapad-laptop will
> see both bits set and correctly shout "unexpected charge_types".
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/2] platform/x86: ideapad-laptop: Factor out charge_types methods for internal use
      commit: 45e6d68a4cf9d9b5b15ce94062f1aba1078b47ed
[2/2] platform/x86: ideapad-laptop: Fix unexpected charge_types on probe
      commit: 721027ef36056f38eb690a17f00be134bd9f9e75

--
 i.

