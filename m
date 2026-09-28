Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9447ACC6;
	Mon, 28 Sep 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584013; cv=none; b=sakyzIJZu6GSMMMntLCpka7jO4Ensih5dJh19MFSucvSMCWK6IywEOvffpNT6fAOV8uyILrYHi7oVtqPc/kFjKEP+lMjF3K2/UczmkbGVGt/8EO1HaehQyucTXVqG+o9DCHTGniWkuhc+8W7O3EWTfth0tHEnkjWc/iNe3EQ08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584013; c=relaxed/simple;
	bh=rbcf7JoA6z66DG+WNueELQVp3gzkmawfrp4w8svXDmw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tisgmyMucl/hOOoOfUzKD7snSFE1FJG+mE9c+BoxoOXVg0nql5jUviyXdU/hxjbsdfswOy9tJYZPtH8vM2E7c8v/MQ87392wXKeTLDvQhbjCC5Fg4g2920Oq7T5an3wvhungDXDM0UJqgP/wAl3xXM0vJIpLD6RxdoJxtmFB3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwEuAckX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwEuAckX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED271F00893;
	Mon, 28 Sep 2026 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584011;
	bh=JvDSIsvqtyxCp0UZ+rOZMxaYFwwbfiHD/BuKlFmkrh0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=VwEuAckXmKey9nw72z+guDriq5nwhNJ4g86AJaYwy7OnTe+bceWPnopuKnGxZ72nC
	 aHQS/fiaFbIIzArSFJ7uzudM05jEFfOSJX++Zm8iMVX+2ufrczpBYMn9VOf/JgKHsz
	 0yply++shrrQxu9ebAPnBFMdFh0++1pUXyE84mWBuhTPCbPOvdJqZhRzw6tT0cSQsW
	 HUjUv8O/k7+fmBOZO84WNYc/aVnjOICDnDyQekIte+JU+fXSAbog8ulrlZENxeZREj
	 VpbZyH1uXe7WkUfJyASXS5bT277moYA506EQiSzcz3T69+xSRypqzBTG9WJ3Up9rVl
	 uGzY2AFd4XGnA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 10:26:48 +0200
Message-Id: <DLQT21LPL3SA.2JOOWK2DTIGFS@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/2] debugfs: fix use-after-free in
 debugfs_read_file_str()
Cc: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>, <rafael@kernel.org>,
 <johan@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "sashiko . dev"
 <sashiko-bot@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
 <20260926195844.1296333-1-qwe.aldo@gmail.com>
 <20260926195844.1296333-2-qwe.aldo@gmail.com>
 <2026092720-sandblast-heroism-30c8@gregkh>
 <DLQ9CHM33ZFK.3HZOB0LIGXGVT@kernel.org>
 <2026092854-script-safehouse-be1c@gregkh>
In-Reply-To: <2026092854-script-safehouse-be1c@gregkh>

On Mon Sep 28, 2026 at 7:35 AM CEST, Greg KH wrote:
> On Sun, Sep 27, 2026 at 07:00:04PM +0200, Danilo Krummrich wrote:
>> On Sun Sep 27, 2026 at 6:37 PM CEST, Greg KH wrote:
>> > This is probably not right, don't do loops like this.  Either fail or
>> > succeed, don't loop.
>>=20
>> Please see [1], where I listed a couple of alternatives (e.g. use GFP_NO=
WAIT and
>> accept allocation failures).  I'm not very opinionated about which of th=
e
>> options we use, but GFP_ATOMIC seems wrong for this.
>>=20
>> > Again, let's see the real use case here, what is hitting this in
>> > userspace today and what debugfs kernel files are causing it?
>>=20
>> Not sure if this was hit in the field, but in any case, the reader lacks=
 the RCU
>> read-side critical section required by the writer's reclamation.
>>=20
>> As mentioned in [1], there is also a separate caller-side race in SoundW=
ire [2]:
>> nothing prevents a concurrent write from freeing the string while
>> request_firmware() is using it.
>>=20
>> This is also why I think the API is a bit of a footgun. Fixing the debug=
fs
>> reader won't address these caller-side accesses; something like the sync=
hronized
>> accessors suggested in [1] could address the broader API issue.
>
> Ick, how about we just delete it then?  I thought we had removed debugfs
> string functions already because of problems like this in the past...

That's an option, but it seems people really seek for having a convinient A=
PI
for this. And I think we can provide something that is "hard to get wrong" =
based
on what I suggested, which I think is better than letting people open-code =
this.
