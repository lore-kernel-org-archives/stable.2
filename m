Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F4238D54
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376213; cv=none; b=ulQALmRb8fdVd+paZZEbKe78W7PV8saSqjz1H8Ny9+xtACaXxbmiiw0+I41UO2QUl9ciVre3/yv80LmIQwbI8uYpuFlLlZXCYyuLe0Fl9l0MziqS6xb1eR76eXMmfpBWhUOAkZL+Ucq5W999/Cvyi4oFNMUohAQ0dSv35DsLx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376213; c=relaxed/simple;
	bh=p6Yk20CJcylgrXxAJQUEvRF0p7sAsIT5anlc/D4U6qc=;
	h=Message-Id:Subject:From:Content-Type:Date:Cc:Mime-Version:
	 In-Reply-To:References:To; b=EX9XyTYhN3pKRNtLZgVZfgpV55icqgHHiXMB5PsqBlGLMXqQYdAzIMwXHELh0wYwqFOWIXVVKiTij4SyNRJPO2WArS1FsMUdYEFQOin8yZOSAURs327Lnxpz0mUfuHArYTfG6XEc2pF53sEfBvi+UtRFeRwrLYQ/pzgJNAbKNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kVNLyVQX; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kVNLyVQX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792376198; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=p6Yk20CJcylgrXxAJQUEvRF0p7sAsIT5anlc/D4U6qc=;
 b=kVNLyVQXtijnS0F2MGeNpAWP8spadxOMGR10BFjUQm3I4NqT+ImIHo4t5JeCef5IYfTYiV
 hUHxYKoHfGGE1J9x0wAHeafjLbtOCsz3Ruf0qUvwuXtpmiZ4nbas7CJJrkDUTQw2YfztCH
 x4zZA30HvWF77xZj+vx5ll3DrDOg5FeUkZ0E43hHpxeTih5AUM1Z4QQ47VizX+grUgjpB1
 dhd3IQx0UhnO1cQonhmnTEOOFuqorlcgtc3NW+OyWuqTyoOs3/b/YOgrzT6x0LECOy5fCB
 JbZY73RIzlqULcJD6sUbFdCaSr2RfxSv0ILL7wS0lqFlUhYqDM1vLBOpqNupQg==
Message-Id: <451788d5e97cba38274e663d2b7952c593e959be.461d4034.890c.4720.915c.a7839a9cc59e@bytedance.com>
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+16ad57d83+19f2f5+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 10:16:32 +0800
Cc: "Borislav Petkov" <bp@alien8.de>, "Tony Luck" <tony.luck@intel.com>, 
	"Muralidhara M K" <muralidhara.mk@amd.com>, <linux-edac@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Guixiong Wei" <weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20261018223431.GA3236@yaz-khff2.amd.com>
References: <20261009020447.90758-2-weiguixiong@bytedance.com> <20261012140330.GC15198@yaz-khff2.amd.com> <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
	<20261018223431.GA3236@yaz-khff2.amd.com>
Content-Transfer-Encoding: quoted-printable
To: "Yazen Ghannam" <yazen.ghannam@amd.com>


> From: "Yazen Ghannam"<yazen.ghannam@amd.com>
> Date:=C2=A0 Mon, Oct 19, 2026, 06:35
> Subject:=C2=A0 Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA =
bank types
> To: "Borislav Petkov"<bp@alien8.de>
> Cc: "Guixiong Wei"<weiguixiong@bytedance.com>, "Tony Luck"<tony.luck@inte=
l.com>, "Muralidhara M K"<muralidhara.mk@amd.com>, <linux-edac@vger.kernel.=
org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
> On Sat, Oct 17, 2026 at 12:51:45PM -0700, Borislav Petkov wrote:
> > On Mon, Oct 12, 2026 at 10:03:30AM -0400, Yazen Ghannam wrote:
> > > These were intentionaly left out as it as it seems users have been
> > > moving to user space decode tools.
> >=C2=A0
> > You're making the old mistake:
> >=C2=A0
> > a. a naked MCE record in dmesg, you have to open the PPRs and actually =
decode
> > it by hand. Or use a tool but most of the time, that tool is not update=
d with
> > the latest error definitions, and you need the exact machine info in or=
der for
> > the tool to decode properly, yadda yadda...
> >=C2=A0
> > b. Get a fully decoded error string in dmesg.
> >=C2=A0
> > What is better: a) or b) ?
> >=C2=A0
>=C2=A0
> "a" is better.
>=C2=A0
> The same "is not updated with the latest error definitions" applies to
> the kernel.
>=C2=A0
> And it's usually easier to update tools than patch the kernel (and also
> deal with backporting, etc.).
>=C2=A0
> In any case, this patch isn't about error descriptions. It's only about
> adding the names for some bank types.
>=C2=A0
> The bank types were added three years ago. AFAIK, the missing names
> haven't been an issue. So I'm curious if this patch is actually fixing a
> problem. If so, then that's fine.

I found this while reviewing decode_smca_error(), rather than from
an observed MCE or a user report. In particular, I was looking at:

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 pr_emerg(HW_ERR "%s Ext. Error Code: %d",
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smca_get_long=
_name(bank_type), xec);

For SMCA_MA_LLC, SMCA_USR_DP and SMCA_USR_CP, the corresponding
smca_long_names[] entries are unset, so smca_get_long_name() returns
NULL. The %s conversion would therefore print "(null)" instead of
the bank name.

That was what prompted the patch. I had assumed those entries were
an oversight; the intention was to make the existing log output
show the bank names.

Regarding Boris's earlier comment, I agree that the Cc: stable tag
was not justified here and will drop it.

Thanks for the feedback.

Guixiong
>=C2=A0
> Thanks,
> Yazen
>=C2=A0
