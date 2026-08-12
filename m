Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6E395243
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555202; cv=none; b=H1nvu3XZtbUavm3vwpUBPRMF2dyiD55EX8fcYRte6OI86Fknkx8Q2G+HvpNTEpjjzSKS1jLhcJ+B4d2YjSGAJd3fnyCMdwKkACa1shNlcnHcPgNAnH40vgaUsVMM2EJzHwowLDTaQG/po912r8ITLLJCD7crTGEu/i01oQiBFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555202; c=relaxed/simple;
	bh=CXXdNa3zZ58ew23YZrR/DcJ6Cjwt18AhY+161TY1/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JkpB+iEGu3H47EIE1O8bfSjT/2jF4HQ9oG1wJpr6PeY74te3pAdLtCZkOhWLCQtSipirpMB39xyKa/ztlTSOcGqt7NiOvTt0Pci5LvnNP79bime9aPbLwDYA3+4hD7w2ScnbphQTeyZgPD12Oz7d4y3CcCl44tNvnD8IvOV37oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lGbZt+/Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lGbZt+/Y"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id ABFC420B7168; Wed, 12 Aug 2026 10:19:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABFC420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786555176;
	bh=CXXdNa3zZ58ew23YZrR/DcJ6Cjwt18AhY+161TY1/sY=;
	h=Date:From:To:Cc:Subject:From;
	b=lGbZt+/YUJh5R5MKme32CzsjVFf41CNPxwatGifXpD2gfLI9dUTHIfRW5vbKIdgNG
	 d0fHAfRa4gco9NzmQuJL19yT2+663bQ6rX2a9UnnrjRkI8eQwdbUKXimhwyHm5txuF
	 KOrsQQVj09DwR5DPVPqtsOnJEujfNxiJgW0WzwGY=
Date: Wed, 12 Aug 2026 13:19:36 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [REQUEST] netfilter backport for 6.18
Message-ID: <anyrKBU6iTymdAI7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Please include commit 7e7a817f2dfd ("netfilter: nf_tables: avoid
softlockup warnings in nft_chain_validate") in kernel 6.18, at it
resolves a softlockup and the prerequisite patch is already in 6.18
(i.e. commit a60a5abe19d6 ("netfilter: nf_tables: allow iter
callbacks to sleep")).

BR,
Hamza
