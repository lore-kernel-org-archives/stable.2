Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DD439909
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974071; cv=pass; b=EkuNPpDpDJP4REkfwvyYxXr3ykYKRgLH/Y8c3Cu6C+x1fKKBWcRw/CKGNffYhwN3vwBQU+MPzuNpBoozRk8xytesCLUL6F0UoamfJDVzrhVzaModWisVRI769B432XkKY9H+Obs0ssV06O5iau68yskZ2er9ipeDtzTwbzkJ3Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974071; c=relaxed/simple;
	bh=LccJHv51dWHfTmazwdGiPtOxYE5F4fFp6PNdP0l+77o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAXaTy+EI2Ic/8ORW/rx2RaUFOpp3xs4fH2oXOkco2NlRKX6oShHS9OUVlUx4WV8+TsxrHLZiDCLVUJwwK8ih3KV2sdD29yyoay+TdCMsV1X+scWtuNKdHOfRVEV/ovpOlVO4CQFmsrThU0h7Oy34oGr6G4k/F1+WPpew4Rs8X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI0WLstc; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI0WLstc"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f3ece23165so1971326a34.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786974065; cv=none;
        d=google.com; s=arc-20260327;
        b=HsFVOUjAN/T9yOrJ6ZT1W84umi2FS5I2HnzH/XwB8nD2niILhXx2S5D/gVxlzwdMEx
         uQEaJHYX059zmE7qQu3xnYgEOjHbfTTxBgMH8aTKUXuLUaSwFC02IKA1nAD9TCp0cdm2
         05FnTjg+Cpa0LXjj1XJDu0M3htsdQdvNSb6uoSwv2ESNALWhUjf4VqWgR1UJdKxCrIdw
         /BUH3TZycC2mF6UbSuSrhv7rIlMmf5JNthQu7GBHfXA3eYEnstnH/w8gnrRQHaox6FB+
         gAKfAEv9PsQnznRx0+lGoKobLH9IACFZc3X+b+tLSk84pt9LfsMi464CtLJl+BscmZH+
         1dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oDTS9dNSi8/M/pYr4xjwQbPNngmswF+O1PTtSVfQuX8=;
        fh=ZL/qH3s7QdNRSwxSO2mqWhGMljdaYxIWIGRU2nZjGlg=;
        b=HVaGWN4KTamkps0KhWbs4z/N6vh4ngjHQ8B4FqKy7SDWu+zb+CnIIhgYYZsjLBJbOp
         OjLlhLujRQCVRaI6Lj6NsbMXlXzi8aUouxkD6dB/9pNiOFK37csRgKRDxGKMd4g/cecV
         7kAFU2puc37taMxBlsLg8vcl7Gaw0d7OPJrJ9fiGzGufZgQcfdZIme9N/gpGxB7czAes
         LYQWLy6oWfAvuEOWc1Yze02aUnXMiSUbDjZue0In/xnuXUfLg9LOCD7v/DGzZnqELVrx
         sPWEjWlzcRDNB9AbHB/fgbs7BGEtNLFPpB403U2pb3sxnHCxIn9RryGUCgBpxe3iTSNF
         gRrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786974065; x=1787578865; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDTS9dNSi8/M/pYr4xjwQbPNngmswF+O1PTtSVfQuX8=;
        b=YI0WLstcjecGun7YCagn2FYgjw3+zs1jjMFE5gEIlRqMJG6cTLT78Z/LPprQ8YJVd5
         oryrflmEQBsURJDhZUk9Jr7kPu1oAGNduzP0+j5yWu9XfCOnElbG7W34PLImxFXyZ6GB
         yu4/v7yUpZWbt7NZYhi0s1fT16c1PM9HWXcxDdZOyjwiOn3mz7fSPjh+iPu7CLPOPhOz
         kKIbK2RonvSJvg6GRsY2m+Y2g0Yl4+SEkDxsXgAUZg/NsrutODpkCVCPw/QmOS9M9S5z
         mCEK5VAJTkfcm7kgaxU9FNn8P+alIgvqsH17hbfzzfecjCo+mC4o0eSRxDelZam+A/Ln
         ts0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974065; x=1787578865;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDTS9dNSi8/M/pYr4xjwQbPNngmswF+O1PTtSVfQuX8=;
        b=hzZnKFPFgwarG9l8b5mbzXzsmYmKaV36OCMos9XsQfC+DN/9n6zRgLtQLm7VcQeQ52
         Fa9XN6JymU6FU8y8qNut3xyRNeSUJ5KF4MZzEvHbZH6BCYp1XRLXW77pxtKnGTc6Rxe5
         qIWj9hW38bjzX07FAg+AoGgA/Gmx0smWotCvGihNtPz7E4yBQSbsbRnQkIqtzmKAz9B4
         7x8eysLfsHv31lyNDrtA0v2Mzo2pJMXjFgoh1Qpy7zV89RyJRTg315Baqk80RXSsjs8D
         +ATTaeK/aNegvqb6pPdZ6eYgj6mk2gymwlSb9w3VfRDzDGE24zI1sbFlJt/Ib141HaZ0
         MEpg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1gypZYcYLdhVUi+HAjnZ59G5tltr9JnasMgLioxhflSMuJomKLtZtEcnqs9Ty5UhegaXeq/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZD+4VwLkWwZsStR2r9cI9nKlUa3JWPuIHB7EpqPAPYaXRJAV
	MiDkx464AGUF/ySRp0csHbUFSH4RhCJLPp1sspJVKe937WeQzJ7McAhG7DP5lWoekG6e1s5I47F
	bqXOlIGj4I1OYzKNJvqtzJLbN72X4rfE=
X-Gm-Gg: AR+sD10YiK/6mTC3EB4zprW+AQjTJqu5dZGPH7ipyEOLNwGyU5bMIdXXLTCs7SMGM7B
	9f/XFzpoWSdvYdyHHbJAoK+26jguhj1qKIsBkXNEicFz1BvjAUA20m0NaQXumlsG+jgIc1qlKbh
	xfIACMpYw+dTGlO1HHBUWk6FOPmjKf8thqqMdMeMgu7gQ1108BbeXOljXiUXXPLuK3pXGBO4i4N
	P+YNZv42d5cDQrOOexFNrMMxR3dg1RhohaQyKmZ7LWiZofOXKCNmEeKuLL3tVbkZqr/lIsAG+Pl
	Ni7nVD0M2f8o5l8SMGvxzxP1HgTU6lS1r/bt9m7eTYqXJZSiOtDbJS1IGAat+d0ZMvq5EXP/Y9I
	=
X-Received: by 2002:a05:6830:6f85:b0:7e6:deb1:485b with SMTP id
 46e09a7af769-7f3de691f65mr27293555a34.16.1786974065393; Mon, 17 Aug 2026
 06:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815193839.141406-1-devnexen@gmail.com> <aoLZ5e0ffVvZ-FfB@zed>
In-Reply-To: <aoLZ5e0ffVvZ-FfB@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 17 Aug 2026 14:40:53 +0100
X-Gm-Features: AcwNN1USfhnetw2tQ9PDyWfNQbBpx-4phjp8VYLXp0rsU7HGDiG_ChLUo2X-AbY
Message-ID: <CA+XhMqxR+m7Jt0UUHetCfXSHHtW5w-jUc0_PSSWjTbprYn8ZwQ@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo,

On Mon, Aug 17, 2026 at 11:59:15AM +0200, Jacopo Mondi wrote:
> > whenever the driver's type_info[] entry is an uninitialised hole, so
>
> This shouldn't happen (an empty type_info[] I mean)
[...]
> > held. rppx1 has such a hole today; fix the core so the walk terminates
>
> Uh, where ?

Sorry, I should have spelled this out in the commit message.

RPPX1_PARAMS_BLOCK_INFO() is a designated initialiser indexed by the
block type (rpp_params.c:13):

      #define RPPX1_PARAMS_BLOCK_INFO(block, data) \
              [RPPX1_PARAMS_BLOCK_TYPE_ ## block] = { \
                      .size = sizeof(struct rppx1_ ## data ## _params), \
              }

so the list reads as dense but is indexed by the enum. It has 17
entries for 18 enumerators, and the missing one is AWBG_POST (== 3).
The last index used is LIN_PRE2 (== 17), so ARRAY_SIZE() is still 18
and the entry at 3 is simply zeroed.

A block with type AWBG_POST and size 0 then gets through: 0 is not
larger than the remaining buffer, and block->size != info->size is
0 != 0. block_offset and buffer_size don't move and the loop spins,
in .buf_prepare, holding the queue mutex.

> I'm not against this, but it only makes sense if the driver populates
> the list of v4l2_isp_params_block_type_info[] with an empty item,
> which shouldn't happen.

True, and rppx1 is the only one that does - rkisp1, c3-isp and
mali-c55 all look complete. What bothers me is that the loop only
terminates if every driver's table is right, and nothing checks that
at build time. A missing line in a driver would be a rejected buffer
rather than a stuck task. And a block size below its own header is
malformed anyway, whatever the type.

That said, rppx1 needs a patch either way: AWBG_POST is documented i
rppx1-config.h and the driver probes rpp->post.awbg, but the block
can't be used today - the size check compares against 0, and
rppx1_params() has no case for it in the switch.

Happy to drop a separate patch and keep only the driver fix if you prefer.

Cheers.
