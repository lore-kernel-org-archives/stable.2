Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058F44B66B;
	Fri,  7 Aug 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083606; cv=none; b=kIL2rL9q8SNHrS9osYzFszBfPUUYqFARYxzXayVa9n2c/PmEFudP7end52W9FZiMbZxyqOaFhQi7iqOLp/8++oxHFy3CqAlYvBpHRahlzaqFRDQl63ThJyH2Svo1TaXbO3UNpKRCpeq3zdLVCJy8kzRcuTeEq4jqcKiUCGuMShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083606; c=relaxed/simple;
	bh=GQw3C+1Ynpb68BBx41hITG3G7haoC/NbbbPKIRPKM/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1HEezEGZYPsr51K8tNo5FOW6ubSRinYMTiGycSNWnBDn75rePorExovgHj+TiQNLqlM3L5K3/VUVLi42s309cGpNWsJ+lU3EgPkz4Qfbl9YEM5zbG+ig+NEej/WibtFMqvEwQr6WOqUMMwTft3P18GXCrlyVBgVEyGyNKRMTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1yyMG4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1yyMG4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E433C1F000E9;
	Fri,  7 Aug 2026 06:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083604;
	bh=mPDjeg+Dj6+CeoP0sjfptrwAQh29XTyZ8VXMGWCZ8fY=;
	h=From:To:Cc:Subject:Date;
	b=Q1yyMG4pSsR5QENz8KMhrQ3cwsnOrUGarKFfrQE844lEv8cWFUZYYi6AVB6zy2O4r
	 0C7tKMZHQ0rGXJAOK6a+KeRKS+mN4bp7/gxeO5l5pp25ZIjZWBsO6Fqzppt6X8Hwcd
	 dA1XT71NoVENCQ5YzTN6px5TUW8B94LWWAsAFWno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.182
Date: Fri,  7 Aug 2026 08:19:42 +0200
Message-ID: <2026080743-whacking-goon-ca2c@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.182 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 arch/x86/include/asm/nospec-branch.h |   61 +++++------------------------------
 arch/x86/kernel/cpu/bugs.c           |    8 ++--
 arch/x86/lib/retpoline.S             |   61 ++++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 58 deletions(-)

Borislav Petkov (AMD) (1):
      x86/bugs: Make Safe-RET robust against interrupt injection

Greg Kroah-Hartman (2):
      Revert "x86/bugs: Make Safe-RET robust against interrupt injection"
      Linux 6.1.182

