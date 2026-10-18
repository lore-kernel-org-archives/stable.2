Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9C392C20
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792321931; cv=none; b=EGrzg1wixrTbH7ijVG/WNfzSmBtaEREsOv6XM9+Gli+qc4VBDUZIhz/XkmoKnbnlwcyUi/eHC8VF1YR2wfwNxm9LIv6Ia3u0V+DXBOzv530heUzQwY72lqqEDrNuGUqDpZnOxus4BMaKUdbuF/Pl7J0dR95dYRhQmwjD0PbqSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792321931; c=relaxed/simple;
	bh=rQZYBRnwItqMgDEQCgK+aU9yFlbsMszBnHN1UbMX6SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PADoc1bSRccr+FR6izGyB5S0jk8UjqFyuGY99f/5vs0KAjx3HX0B71BUPkqp7wd93E5UmZB3rmmRHA2WAM+rm/Byom5GUOS9J7XaJrq9yJQL59/11sjjazp6Jcz6hvZwg/JsY0NalxBj4JlnziqjP1auYuI7SJQuYpggHPsr9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ametros.net; spf=pass smtp.mailfrom=ametros.net; dkim=pass (2048-bit key) header.d=ametros.net header.i=kernel@ametros.net header.b=m5C/iKHj; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ametros.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ametros.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ametros.net header.i=kernel@ametros.net header.b="m5C/iKHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ametros.net;
	s=s1-ionos; t=1792321927; x=1792926727; i=kernel@ametros.net;
	bh=LCKM0eQxsbocvedXU3BiqvTFdXbr9gWMxfeSvsaIezI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m5C/iKHj0fkXOnTmC1yqc53loecH6eM1hJlbnzbeyJX43lXMhq/ppsfEW/Fo2dCf
	 avCCTgRqwL7qVUnxOuKSnsO5sIphAn5fCY07s8IbNdBkMtQBWXBDxuG/JOO2W/CYO
	 hEo4pguU2GgT69MXiJ4FCbyttXrvEEY3wN9u+DetBsxzXic5M73o79DpEk46XTV3v
	 YQVKbHIuWO8jzMCBBBG0CYq3w7yYZP0NGEOvYY9XLrS3xRVrVMZWt4x5VCXOWcUP2
	 f5qcSQMKs8ZH3qvW7TWOKBUS1w/t6lR9/mrCnh8a4uYeWMz32WOE218Bhc0kZQSYG
	 xcVn7yP4Er48+3Rbbg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [213.165.67.103]) with ESMTPSA (Nemesis) id 1MLi4W-1x0r8H3ELA-00KeA3; Sun, 18
 Oct 2026 12:19:17 +0200
Date: Sun, 18 Oct 2026 11:19:15 +0100
From: Bob Anderson <kernel@ametros.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfgang Walter <linux@stwm.de>, stable@vger.kernel.org,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: regression 6.18.57: acpi power button vanished in machines
 running in qemu
Message-ID: <atSdI7buRErdF1jZ@ametros.net>
References: <5fe757e7aa54c38df3525d313598db99@stwm.de>
 <2026101834-parchment-reps-0bee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101834-parchment-reps-0bee@gregkh>
X-Provags-ID: V03:K1:oB6psnwJ8pFGHnVDLRZ1jGFYj1/Bn/jDMcjj3Q8vD8o+fV7akeN
 aScMsq5IhJBogrTmxsMRgIu30wzkbD/M+kVKz5OV8VfvKPzA9sWJGwwC0zeCJU3ivk00MPt
 CgkMhwA5/PP1SVyg7XMe0aaHXhqqajighp/N2WNGUzVkiYLiu2GfV+J2xuUATvS1sUpBFKZ
 mSeywIea7MWwzDlUb/s3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XN833mP/Z+Q=;jCipp5TJAsjOh8IznMc/Rsw2bca
 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
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 08:48:03AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 17, 2026 at 07:26:54PM +0200, Wolfgang Walter wrote:
> >=20
> > since 6.18.57 there is no acpi power button any more in virtual qemu b=
ased
> > machines (as far as I can see model doesn't matter).
>=20
> Can you use 'git bisect' to find the offending change?  Does this also
> happen in the latest 7.2.y and 7.3-rc releases?

Reverting 38c79dacc8063ff8a0d75ce2a900fbaff82ad94c makes the problem
go away.

Reverting cleanly required reverting c85f325d9ec3116b0d4ee9d5b76c26aea0ad5=
ce0
and 78677084cd09001c3c815aab80c59708130a65d7 too.

FWIW we also have this problem on hardware (various Dell servers): the
power button and "graceful shutdown" via iDRAC no longer work. We're using
a custom ACPI daemon that looks specifically for ACPI power button events.

thanks,
Bob.
