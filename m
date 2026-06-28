Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF01348C68
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661722; cv=none; b=iJELrRSp1kmX9EUN2kTaZ9hk1JL48eorkEhx1ARKrgwub+/xQiF/Mnq+eHsEoUQjXflyteaMPk3mXmWol2ixnktKLzoeaXtV/NLcCuuHudAD4Eju5dY61z/pBAqt20F1QflcQ5ss86HF6AiqEkNPoRUa6ldDOykXvq0IyTdQ5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661722; c=relaxed/simple;
	bh=gPIXDlMdWCBMQJSSxFhAQbsceBHRfDSzINaETnpvP6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvMH6QdAjSQXx2Pjl8mxN7DNDoyJCl+8NgV8fO7RAbF3BRYyJT10Hyo+2gE1spt+JtmGgShvJTOwHleYAtume30ybFGVbXsuPSpv8EdWS3SlAgDA4HeJFp0f47PCclvxR5XbT5TlXdssx+kr6/HCC4HSuVF9ceEF7vwHWMWgN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=VQ/twAq0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="VQ/twAq0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-929a7eeb0c5so241545785a.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782661720; x=1783266520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YbP6a6goP2U5MBu9nnomcsOpAn0oXahZ7R9xiTcBOF0=;
        b=VQ/twAq04oAXWAzoHlUnh4ktiEQlvzWDEaDsLREWzfFOPBnN29KC/ms6mnuceGNZPT
         ofmjcykF8ouGBu3w075OLuRDCOBqNWoZ3KKU+TiGqEzR3Xz+o+qF4QsJJXUnO1lL4t6e
         m+A/Tw9VzVI3VaNv2dZ3I/3srbSH0DVgtjiXiVygemE3Tj9AHMPSsaQuRI6hj4tJUfbE
         jSJ0najHu4xL/uCh2cYIpz5+ERE6vOmXo6pQ37HDPN92JEj2Wi+rTAjFBRvIPbDvQrHq
         h5iRJYsfyx9r0DqElFo2sRv7oJNDlQ8jQiFiMIP0Fp+XBn615+CJzm7GyqLKgvmDUIgc
         oI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661720; x=1783266520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbP6a6goP2U5MBu9nnomcsOpAn0oXahZ7R9xiTcBOF0=;
        b=EWGrjJWPWZbF5BlXkd1A2goyIeIlT2j7H+zhVwWFJi0vUwhdfncAXiBSDgeHRgc+ba
         fBMggQTpIGxGJHXw9FB05Na13x45I5OkYYUCyLqMiKJB/Cx1lZCzJh7RdobzXNi3W4X7
         FtI0bvVyR37KBzm4dkww8k70xtGX+4LjQVZWgXQD19y7HDZinnpoawPJ6rJxhWScxB5i
         0N0jIATXdZqi+zkN5xmIOiLHzpJhw+cT19RH7OP8V3rjFkTNpuWvDpeMq5lPJJfc0yzq
         2+majw07r3jxQs9IhjDZ5O01NXYsatw92CneRo4kp+GjFMWDkulos61rDvcPssjXiHcd
         IfGw==
X-Forwarded-Encrypted: i=1; AFNElJ/4wc2Vfr7iNBuv+ZdLIlxlTbye356gO/lwLgc9dBipUClXzOZcq62SzFT3MHXpZiA3C4eI6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6x3Cgkqa96S0A73/3Tg+rpAFduesesByUFfgmvCqz7C133fe/
	SHDnRcOraGag3+PGAGBbSGs3JJ0kutryAtRa5adQC/8M3nvP/AhRQbmfh2EPY6wafQ==
X-Gm-Gg: AfdE7cnKgZSTIDJpaTl2LzktTrPz8IvaCFmLXUwVN+eey/TyIjaZrSZHyKq52u2Z7Kt
	CyhQuCEyjgQq8lQj/L2GXiEztT7HStLx01SyfY3kKAcAKhLP0jAdaM1HVNkhYrljVBtE+fB5ey8
	cWJhusm+1SqWvuPkryXI3gMC43QoM2dLURUvauHJLiNKide4iro+Ikn61qAh3UzNULw5D5R5IbJ
	EkSeG+ywXbcRA+/jq5mFEub4LR7eApz+ok/FYduqe8jpxyAAD1tymNL5xF8INrq8imGO7YqeV1H
	DgDz0UGYb3vmfMtiyiGBNQWUMgxlpA3/JnetcUK2MnqfoKmylZ3MRVjiKOIS/lWZuLQs6TS4XFK
	RdcwzwdaO+N24C36nqSjckMnTJZOuByAV2p/IynAZYZ4sN/6fkNeSZccr/qECEDQz218N+FQUHg
	CwkpNOLwwNyAFhWyEi7CCTW6ya4buxnm80
X-Received: by 2002:a05:620a:4613:b0:915:aa65:6e95 with SMTP id af79cd13be357-926039b55abmr2307740385a.44.1782661719983;
        Sun, 28 Jun 2026 08:48:39 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a1892sm1783735885a.38.2026.06.28.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 08:48:39 -0700 (PDT)
Date: Sun, 28 Jun 2026 11:48:36 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <62e1fab3-1045-41f3-bc74-4c7624011619@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
 <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
 <20260628165040.76fd608d.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260628165040.76fd608d.michal.pecio@gmail.com>

On Sun, Jun 28, 2026 at 04:50:40PM +0200, Michal Pecio wrote:
> On Sun, 28 Jun 2026 09:55:07 -0400, Alan Stern wrote:
> > On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> > > I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> > > out how to make it properly work with my patch because of the
> > > following reasons:
> > > 
> > > 1. I don't want to move it to the top because, from my pov, there
> > > must have been some reason for placing that quirk where it is now.
> > > so i don't want to mess with it.
> 
> git blame is your friend:
> 
>     The DELAY_INIT quirk only reduces the frequency of enumeration
>     failures with the Logitech HD Pro C920 and C930e webcams, but does
>     not quite eliminate them. We have found that adding a delay of 100ms
>     between the first and second Get Configuration request makes the
>     device enumerate perfectly reliable even after several weeks of
>     extensive testing. The reasons for that are anyone's guess,
> 
> > > 
> > > 2. Regarding my idea of adding a condition — so that it doesn't
> > > change the behavior when the quirk isn't set — if the full
> > > configuration set exceeds 255 bytes, we would have to issue a 2nd
> > > request. In this case the existing behavior would be more justified.
> > > 
> > > So, I'm a bit confused about how to implement this properly. Adding
> > > yet another condition to fix the second case doesn't feel right to
> > > me. It would look unnecessarily complicated. I would appreciate a
> > > bit of help and advice.  
> > 
> > If the 255-byte quirk flag isn't set, do the delay before the second 
> > transfer just as it is now.
> > 
> > If the 255-byte quirk flag is set, do the delay before the first 
> > transfer.  If a second transfer is needed, you can do a second delay 
> > before it or not -- I suspect it doesn't matter.  If you want to be 
> > safe, add the second delay.
> 
> How about "keep unrelated changes out of a stable patch", i.e. always
> do the delay (if any) after the first request, regardless of size?

This is not an unrelated change.  Rather, it's deciding on how to behave 
in an entirely new control pathway -- the one where the 255-byte quirk 
flag is set.  The old pathway is completely unaffected.

I suspect no devices will have both this quirk flag and the DELAY_INIT 
flag set, which means the location of any delays in the new pathway 
won't matter at all since they will never be used.  But even if some 
such devices do turn up, adding an extra unecessary 200 ms to an 
initialization that is already at least 2200 ms long won't make much 
difference.

Alan Stern
