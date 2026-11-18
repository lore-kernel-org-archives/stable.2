Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020526;
	b=cu6fY3apLCAJrmIqFqg0xi/bpeIs9jJ3FwFzA5ez5CbViz1pYSq+rCmWW5FQp6n7WGOC
	 ikjwlJUuQdwDnkB+uO9dabLKUOND060GodKpO+TTnUPVUX0jp9F5e0WmaHxxkHZ5QOtMA
	 XQFoaIG25REqLibzPtyIIFq7rRDcZN6jAbehEg7So2ubdsHzSi05u29iH3imkDqKgR1Sh
	 iwW86L9QnHDU57dBAUqI2aKC6tU53DKTVCo1kA7+56E2DbohwsUqZ1fBFlMWTYG0S6/wX
	 4sYkHkTrz0J3Uc259f3bn6oV4hRHpEEqYPQa7L+BPbEfRAK5P3aW7iIx9LYy+pMKR5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020526;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=miTxn25ctvzo84ihqxeAlmk7XDh4mD7nIOo99nLddxE=;
	b=Zw37JGTC7/qa3AWs++WTm4+h+DL8fHgmlx32p10hSNrJvcedThXJq1wOEqHZaVV9Lcke
	 jJ/tWmSNae6WYczI5J3IbfA8ETuBCcbIk7IlUwB3fCltZ8qQ5B0+y4MlIJ5i1K9I8Iydd
	 jb4YyGEBsAuzXtJ8c8aIgV9aSyUpkkaQqEWCNqSvS8VONrrTDx0IabJb08AgONGQqeyDJ
	 Qrl2vhLKR7f85hHi6KbXihMRavlxmUGQMriWmz03GTsNODSTuzq4HjBG/dY3FfPfh47/V
	 lRuwVRfmP1rxUYwOVJtNJw1VDq/2GynU4XBm/cW/r5y2z3OG0U95kFrR3qeZYUTiPQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="p4Q/E93c";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3029606A31C;
	Wed, 18 Nov 2026 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3029606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p4Q/E93c
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1D2143D;
	Wed, 18 Nov 2026 08:48:42 -0800 (PST)
Received: from [10.57.69.78] (unknown [10.57.69.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4C03F673;
	Wed, 18 Nov 2026 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795020525; bh=tWe5dXBkId+JNgkn9XhUiubNQFbD2xY89r5uLnS/bR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4Q/E93c5E7cE8D2wNJonXu8VDfLu3f1JSwUYMf/4XGWq/jlpqL3bG9nRy4xV+D1A
	 xKkWHyo0WketnMZBOUHV7i79upIHeQvckteKJLjoobn4+VepMpyEDqU+2DUiPs4KCp
	 E05UKbeyP8Ep15Fr6A9XAB2Heh0iCE9e0DwzzNUc=
Message-ID: <cd17d0fc-2859-4969-9677-692aaa2db0b7@arm.com>
Date: Wed, 18 Nov 2026 17:48:42 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm_mpam: let low level MSC accessors return an error" has
 been added to the 7.3-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
References: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com>
 <2026-11-17-1-daily-reply-0009@kernel.org>
 <8b078536-4101-42d4-bbad-d251cedba4f0@arm.com>
 <20261118124002.3727477-3-sashal@kernel.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261118124002.3727477-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 11/18/26 13:39, Sasha Levin wrote:
> On Wed, Nov 18, 2026 at 11:03:40AM +0100, Andre Przywara wrote:
>> I will send the stable backport patch ASAP.
> 
> Dropped 84e8795c271a ("arm_mpam: let low level MSC accessors return an error"),
> a3a94c13c442 ("arm_mpam: propagate MSC access errors for state saving
> function") and 197a7a41e6e0 ("arm_mpam: On saving mbwu state read the monitors
> before clearing CFG_MBWU_CTL") from the 7.3 queue. I'll pick up your adapted
> 7.3 backport of 197a7a41e6e0 once it's posted.

Thanks! It turns out that this backport patch here logically depends on 
another fix (197a7a41e6e0, you mention above). So I need a bit more time 
to figure out what's exactly going on here, will try to send something 
tomorrow.

Cheers,
Andre

> Also dropped 643b64025650 ("arm_mpam: Release the mon_sel lock on
> mpam_save_mbwu_state() errors"), which needs the mon_sel_lock guard class that
> 7.3 does not have.
> 

