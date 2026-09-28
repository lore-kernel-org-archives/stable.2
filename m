Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C0448B80
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578652; cv=none; b=ESbmDtIcnxaZGzmM8jZHn9bpnAQxlwmy9EOrhGzue3kG0q6X4KCiTEHv6oPXBWn5eycneeyB6k58UWjh6DnnQSNJZi5xSq1gHJW9FvupXSioUPpdRtbiL3OY+oDRLsEewsRdgfxJtuXHyGeAQQZnAXk4n7n27RJGG2t2b9bdN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578652; c=relaxed/simple;
	bh=iOLqsr/1Pfab3GjsjU48cf/53tj6Xn2AGw1oUU82SE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCV944jUNs0CgzfzUpJ+88Eli6PChD+Go3aTvDPt66ErJ1Qqg1uX6q6rsD3P4pP7wtipKv75ldheBX9lKIXwPBq9+Q9wBzYxIkJKbOnuzOdinpYEBlzG/icQZ/CqJjnzFnmbmYf5bqAXDfLkhSBVQpoRWV2HmsHgsVxWbdLb+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL+E3Ce2; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL+E3Ce2"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so2002446f8f.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790578649; x=1791183449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+uv1v96meiRGy5jfT/pRvcdeWPwSROmpvTYk5wo6xM=;
        b=PL+E3Ce26eBaVIYWytVt8AiDxUTFZ8Q4RnMXDfM0/ep2ACua7eYf8Ud5wx3+uBuVMY
         I8QApa1DMkYNj+nKyrYLx88btAHJ+OJy6YXqFgDJsum+YaIjALHAGb0XuvWMTcmdAkkw
         6L2wqISF5EW9mGSBwFtDUUJmazhOVcS8Y6bn7SJjqf91F6Am51mLuSGPhmwjcgW2bIfa
         0kwhOaiaigrP4rzQZ3zl2REKpZw1tUAAqmrgRIOoF31DmfFlekXftWbFZCyBJec0bOaW
         S1T6kqQb3Fc6MUWQPv2Cl5OQesBscGPkkO8w8rJHanLl9Eq6zcZhLmbKu6eSiyvpeYy4
         7FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790578649; x=1791183449;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+uv1v96meiRGy5jfT/pRvcdeWPwSROmpvTYk5wo6xM=;
        b=wc+HnXewmw5GJ2pSTOgFCYOp+YPNXpNq2a8Y0jRNyq+4A69szE0ZKSi78ckN8D2g/y
         V/JDg6hFNRd2evXxfjzm1eWb5bjAWc4gW7C3xl+YC0n75HKj+KWCgSPJ4+JPbvLuiGKw
         Ry3zbK2Zb8Nf0KuyB4ebmiOlPV4bGysybIWSCGTIDGws7Pxksg/EcavMOMXvii8NS9Bq
         0fmmJErb3dsAmg+ySfSd7o4gqOEk5EyIFNemhF+8RSCN2J5xXLsCaqodmhD20Bo4spay
         O4JgBIaAua5o40522gpkLYvl5cIhe/0XYj8GVVAIWgoK12q8IQTa+Oq8vBmi+QxTNLOL
         0XCw==
X-Forwarded-Encrypted: i=1; AKwUvByTbTAIEeNEvg5Ru1FEo8j6vG+moQEzcIAjpnmDUiobqQWHqWC+Z+9YoMBaPKd8ZAgmTGpdXs8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpq8zczclrIFslufoxhS/tCZMN0WMBZuGFMu6Su7aHbWrWCKXg
	akk/oTGGdhsV7WZa19ZldfNVnyQmd4ASj6OndYP834akMA3gSidJECiY
X-Gm-Gg: AYBFou1BRNmkg7pvtDzyIiviGDZQvEJILuff4/jacmtcC7esPiLAGn4KIu8MVctsQB9
	YOn5l5dunmhZIBwZ9UrWzyqAimOlGVRPQoEEGxrU5T+t3Un6Xf4kwEO4KrM3EuFnpaNsd9TV+Gk
	UNAGc73HFxShWjSgJwXcibSOQkhvsNriFxhQnrUtbgdMMTHUxeBb7hCRg5U2xNxGOvGRUxNANZy
	kDqZjEXx8cd8jL2LjzeD3WSzw7cbaOdvEy0bhHkB/BJ3OyErgpR7gAybXKgFbUGymiDDxmCqqex
	aQxgJHYTifSCz+e4VdJA7mNi3UVrPRzpwzEubAdCEr5JBCal2dCd5eifEsnvzgJNPnW2nH0BNRs
	WeOx1qg1GGIFReGfpu2V+uA/MQOxZ/pPSHyTEWjrnvi8gPjSGaOUI3+Of+nubrcFIHsBBGXNeWh
	wJsQHgsxbz52lB7K8zyJ+RYZjvoyvJUlj8Yjo0tN4vSMAf1wqQy3mkXSDvape7VC8MsxA=
X-Received: by 2002:a05:6000:4545:b0:488:7d08:edbc with SMTP id ffacd0b85a97d-4887d08edf2mr9877854f8f.24.1790578648847;
        Sun, 27 Sep 2026 23:57:28 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ed6esm27630582f8f.29.2026.09.27.23.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:57:28 -0700 (PDT)
Date: Mon, 28 Sep 2026 09:57:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: Philip Li <philip.li@intel.com>
Cc: Zihan Xi <zihanx@nebusec.ai>, pc@manguebit.org, linkinjeon@kernel.org,
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	bharathsm@microsoft.com, dhowells@redhat.com,
	stfrench@microsoft.com, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH] smb: client: avoid NULL resp_iov dereference
Message-ID: <aroP1B0gG2Mhtjzf@stanley.mountain>
References: <20260926132208.23360-1-zihanx@nebusec.ai>
 <arkuJtmhKDAFnzTl@stanley.mountain>
 <arn+UIhVhM4QDP0c@rli9-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arn+UIhVhM4QDP0c@rli9-mobl>

On Mon, Sep 28, 2026 at 01:42:40PM +0800, Philip Li wrote:
> On Sun, Sep 27, 2026 at 05:54:30PM +0300, Dan Carpenter wrote:
> > On Sat, Sep 26, 2026 at 01:22:08PM +0000, Zihan Xi wrote:
> > > compound_send_recv() only populates response vectors when resp_iov is
> > > non-NULL. The final pre-authentication hash update nevertheless
> > > dereferences resp_iov[0] whenever all compound requests complete.
> > > 
> > > Guard the update with resp_iov to match the response-buffer handling and
> > > avoid a NULL pointer dereference on callers that do not request response
> > > vectors.
> > > 
> > > Fixes: 62432a3f5145 ("cifs: Clean up some places where an extra kvec[] was required for rfc1002")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <error27@gmail.com>
> > > Closes: https://lore.kernel.org/all/202609241449.HlHmnZFZ-lkp@intel.com/
> > 
> > Originally the idea was that I would review these and filter out
> > the false positives, but these days people use lei to read email so
> > they recieve the unfiltered warnings.  The zero day bot should
> > probably put a "Unfiltered warning" note at the top to let people
> > know the warning hasn't been reviewed.
> 
> Got it, I will add this note to the bot report for unfiltered warnings.
> 

Thanks, Philip!

regards,
dan carpenter

