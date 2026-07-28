Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7242378F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238607; cv=none; b=jKB1feDY4yIKcw8JEyFuDlpKrKxzgdHE73+wD3wYW8ABNWzV/Bjrj02wSoSSBQVWmr8oP9veO1ezskJgLFN+BCZiB2UJI3FgW5CBkWr3Ajv6YxDAXqYbS3g5o/9jvFMUkVE59tATkZhrVF1k/MtG9oJ2jo8X6PcYKovSKPv+Hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238607; c=relaxed/simple;
	bh=etyOxhZtuIAJwlcg8fQ7QuNknS3EtiZbY1soNGp9BIU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy/ldtZyCgxrZOj9XsogEGiEVBq6O/fYqmVnalurwHS0eExoVOg0s1UFP/5fTkdWf25ebST2rQK3v1vhk60bupD6Ds7+OX1Jsl4f6L1dP3c0PVN5Wk+O8O+Dkok1Z1s+fIbysrfbhjrhEhYuu8RGhn/k3XNsqobM2Dk5CwesD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tZ+gFCJz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tZ+gFCJz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1907176a12.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785238604; x=1785843404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HtC2XnkozbL1BOm4MB4z4Sheq8vJSJof34ikV5vSyE=;
        b=tZ+gFCJzAGWg50n2lqlTPVzqEn94rQgvyQvceweBomUtwRm+d7lIFDy2Pq+WaxFKPj
         XY2GCftHxAcD4bz2DHwHR7ZgJafmqmSFj2rnmXG50JsDvYckdSNBcQiaxJV+joze1U+3
         icJPyL6BI/VC7AJBdIBUwADebm9O9qscILmt9ilCHws7x9msK28mDkDHmaLqbR9N2i1v
         Mr8XA1/iDQBVn05n+w8gBQlljwuoiAHebWHJSBzpveU+fWHYubcPtPIej481bKmKcqgY
         MQYarnhMEcXLXdRkVdMjkVLOKe+mQNVQKUihbDNCrUrsLT80euceBsqMXNjlWWDV5wzs
         cXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238604; x=1785843404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HtC2XnkozbL1BOm4MB4z4Sheq8vJSJof34ikV5vSyE=;
        b=Jtvunf6rY8/jCrn2U8+bHiNcYwVW959atn+9N+3nRzX2xDUXUOdiW76njwS5GCweLb
         ElvgyRwvufAlnSXrkI4De9Ek4ZLUlMw3LoqhjSHrrbt943kA21vIFltf6TL8XLpHS69i
         dMbhzDPWIH+284k28hG0+cSM69xEEKk3Oeie03f5XdJXhwHhXgIjQlyrqWWsjJB/8KOt
         YaDkquia5kfKHexnhmwli6UrtjKMwgCaajCwbJWRTiwiYBkVqzmrAcTwkm0Amc6yD3Pe
         rY9BAaDOdJeEgZthSVhOn0BjOS7zvEQjk4fxz6JqIdDHehxFslKNCL58k7stvOYsj2fV
         TJkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnjZW96FQ337xIG+aeJx8TLj3bNQ8dDEG4TU7U8hmVuRE9s6MBEgP5D8YcckqEeYEwKJq5FRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNqw19FVDUQKscR8J7L2i1Cy9XlXR1KTHNCV6yrceqaw2Smeu
	Jmewe+chJUOkQHbCXgFCjAfkxtA0fzPtTwIlwZti69qZl0X4aMUuYjW0Wh7lU0QjpXE=
X-Gm-Gg: AR+sD11GpglB8SkFkY8h2u/+KE8QA5HyWN6IVXc7eSIARQCTPb5UaV8PeNqD+OKYAb5
	5soogMRBM4GnMJoyaH8rONg/lfA7cVPNCWNE2v+GR5oIYn0CReHJAz/zK8A1alp/Ot8aBuVnjJE
	fMJDZAwa0wXunROqrCEmrx4PvFIOBu0ctBQ0cp1L9lhTgABZ1zbaF/W/50uVgJ+RNZpkLXftiYO
	jxsPicxmZ1+y7HuzP78bQShf/d5pbQOdtMCAQfLPHaox6hwBaCeGZqTTXrOzw/qyMCVYFGdv7LW
	oUVnYXDBKpEPy7ZBMoSeRXa3l89J/3SO++9Dbei584JkrxwyvTniMYdnvnQ1l2pZ9VPBgQNB0dB
	Pru4PUxCb3j9XtjgDbjhAMpJhFkNMmUO19nfmhmO12eMxOdI36T3QYd2tid+X29osu1c/s3DV6R
	yQ6Z5mPQNBrPxALv41FUMjYX8uBxsLC2QyMAZEMz4BjCJpowIiQo2/amcyg62aAWhiG6EszGRV2
	24AB4MIi4YZqpqSmg==
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id adf61e73a8af0-3c8ba63bac4mr2823692637.72.1785238603787;
        Tue, 28 Jul 2026 04:36:43 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548efesm44173814eec.14.2026.07.28.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:36:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:06:36 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Joe Damato <joe@dama.to>, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: microchip: vcap api: Fix possible memory leak
 in vcap_decode_rule()
Message-ID: <fgtzc4qsfhquom2ipslp6w63v7v4m2gdglo4rzvgrzjbeoq5yj@67lizsbkscr6>
References: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>
 <ameUygDr01/ZvnPD@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ameUygDr01/ZvnPD@devvm20253.cco0.facebook.com>

On Mon, Jul 27, 2026 at 10:26:34AM -0700, Joe Damato wrote:
> On Mon, Jul 27, 2026 at 06:27:55PM +0530, Abdun Nihaal wrote:
> Not sure what the style guidelines say, but the label err and the local
> variable err having the same name is a bit confusing.
> 
> Maybe you could make the label "out_err" and update the gotos instead?
> 
> Either way, the code looks right other than the style nit, so if you resend
> you can apply my tag:
> 
> Reviewed-by: Joe Damato <joe@dama.to>

Sure, I'll change the labels to out_err and send a v2.
