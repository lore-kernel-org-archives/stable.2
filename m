Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D92221FD4
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761214; cv=none; b=vFPNsCZvZCABZf9j4r79nwng9OcZ3B+NJPIXyoF5jkXmdihwWFZ5d2VWKhoeunrOmfeS61QIvsoXhpgNfUXAE8m8wCF4Lls0J5XimlGBruK66qrveyfumLqiudPXkBbQy6q+BURhrU9jmAHWzEwnkAnH12xWd4OTkkacI4GhdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761214; c=relaxed/simple;
	bh=Euq2MlUefmaoVcqWBO1jpal1hGzOm7vsSIj8nSlhKd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDNf7hnQ5jYnSDgIPQ35IarSYX+9U28QEQ7m9bCcvBfEYiGMR2FNU6Np3gaxQTH08lwIZ3Wvks3V6Aniw+ZNZpU9eX4Odpo/mGQOi4A1jwal6EYInm2CVSuJLGsyy3M0p6HP1j4pMK5mkVuI5OevLTOT99QSSjEyBxSZ0vry0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTml8qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTml8qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B77E1F000E9;
	Sat, 15 Aug 2026 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761213;
	bh=W1vquZ0g3SXtLGiljW+zLl70j8uCqgl6zjmVi2V+iYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSTml8qXtqcz/dLGwbv7phXvZnx+SKZyO8+nVWcruadKw/lPIk9A3SIrRuMsRfktH
	 KeV8GgpReJH6l77IS+AIqGHQ6hRNSxf0RGzPsrw1kbxYgYlJl8Ux8IzPTQnuz10/3z
	 FBagZ1O0z/ejNbqvrExzzq7gQTQa4ubMAvDLuTC6f0eOShMsLOLsaNtNfvbIIiQUi+
	 0tu56WQcvc+xM70BNscO9ow9DG+0tqBNy74lCmOGrEfQHDyM1FA6BWBRe5E3iMk7Ei
	 84aVI4ZCmUkTIjjGPHDEPpqjkqcQxduLcQ5iXbV3pXz+pW0hL7XeoyCVUlSKctx6mQ
	 gxxt8j/Ls5JcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com
Subject: Re: [PATCH v2 stable 6.1 0/8] s390 KVM PCI backports for 6.1
Date: Fri, 14 Aug 2026 22:33:08 -0400
Message-ID: <20260814193000.8@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221323.3645-1-alifm@linux.ibm.com>
References: <20260812221323.3645-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patchset backports the s390 KVM PCI fixes to stable-6.1. The patchset
> includes one dependency patch (patch 1) from Jason Gunthorpe, to export
> free_uid(). This is needed to resolve a compilation error. I have resolved
> all other merge conflicts and tested them on s390.

This one is based on released 6.1.y, but the 6.1 queue already carries 2/8,
5/8 and 7/8. With 5/8 queued the free_aisb: label sits ahead of unlock:, so
4/8 no longer applies at all and a 3-way merge can't recover it either. And
taking 3/8 without 4/8 would open a fresh unbounded mm_struct/user_struct
leak, so a partial series isn't an option.

Could you rebase onto the 6.1 queue - drop 2/8, 5/8 and 7/8, and re-resolve
4/8 over the free_aisb: block that is already there?

-- 
Thanks,
Sasha
