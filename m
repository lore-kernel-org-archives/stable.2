Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B503BED66
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900078; cv=pass; b=qJZqY2bcOKCxy82JRsCjW0I131BDQLK2CyeomKDY8PjHzHtLF1lTOdeVVQdNSxYH3adaJbkFIWTF3rUR5tc3ZcOpQjfILpRgmOrpmJHrXrU9QpW+6TMnWVBmmcANd0eszGmjddpBtNlJDoBRcKOw5soHpjziodlMHZZ9XYT1XKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900078; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rosc3uxKF06nN+R/8outsXL4C6Ux4KYk/f0s2r4L0UGXMs2U5n7xv13ooTQD8bJ3gK4J/OUGsfivtwFCBqtQx15JpIuI2ViU8k5HbRzKgep0m8erIWktCq6pch7Plk2DR7rr0jF7qvu/nMVIgtmG1rwhh+tVxNg365wx02w/cSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpUbj/gx; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpUbj/gx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c197f968b3cso67559766b.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 06:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900075; cv=none;
        d=google.com; s=arc-20260327;
        b=NLI+aCEQsYt0i+VMs9dxc8YRjLiIiZLgDijJf6G/h0GvivdebMzmklCtmw9cNJirQ2
         i4FYImgsTx3aMJYFWhZ9rSKBIP+p31L9p5wJ8AAsulY8ljnSbQJlGciyILP+7aoXx49G
         0bGGMI2tcWkqjcAIzf9WRChF0BhIw1ns85aIYjvy47WaozWao+GUHV8xu0LKqswuVwA5
         gyiYfymIn0xc8SQz9EZvKiewvkK8I6SirsUG2bVJnifVmai5O82Ann81C4nNx67qBV5t
         iTOc4DED8zuIuhT95hO0vBqvnbdf46bpmzws8/MOcRSvQvOMyaM4Wgf/2E73NAeEu5Es
         ZptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=iNl+nq16OXPxYZDIHbqSvzzb8Hcg1OdlulNd+4Nuxjg=;
        b=nrAy5p8UWG0SIPf8edGoTqbFZqsp3i+tjKCO7jax/pla1990C1JRYCKdFf78UiwZYw
         W41vVd6D0OzR1PV6bUjS1EtadLRIohcCkMf0+3kXWjxqzaMtPoqecLLCMN82XyHnU41B
         lwHYgAGxJy6gsLgoVB+Hfoa3kUehRpP21Wr7TRf3mocJbsr8DP5jtFQR/E9bLIMPIESY
         dwrxDiEgELXutGlDZcDqvQgPcf9q1JeSdbPJv1tjNwhQQCHrEPWRBwDpnRePJwHt+VQL
         nIlyb24eQ2lYyAYYY7YPHHtGKlGNoSRV2PW0148mT0IuY6v9gY5t+jfn+zFSZNPjBsDk
         XxWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784900075; x=1785504875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=VpUbj/gxPfu2RJKKVmjsZsjVpFXa4JvxOTc/1TcRNMnnNVefaCvfqx2/odkO9g0NTh
         CnsiBs4DgQ48FWOpJDSSiPo0E6xIq/kxYpQsS4Dbv3aZurShT/W+A9qHMjEDVCTojNe5
         5zf79qnNQjhwS1zaVKbawSHze1NF4okyEJHHH4ArW6N3YMjavlI7eyMl+xOpiqmxLb2E
         NKJ06T7BITwLjVRs4DNk4bAi3fEzM1kirP5LYLY2pSojTlhlTzeIY2DM5oDjrSJ0zXy8
         zsPTuXchjV6bQkcVQAf1IJmIjWs6rbLpwnX15kRDf5kjA369ONxgdH7bmD2X4GrAZEig
         ECZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900075; x=1785504875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=IAR3EQQJMhZ3IiIzI0sGnDK+9+cZCCIpffftb78gnp/4xDyZh6XrN4O5kmqZXwwDz+
         HgZB/6ida3wpxs3gVhIw+J7R80d0vEmhnxzhHnJwvWne+NIM5lKyu2iGXbxQ+zX/jLJc
         xfBCzlI9WdbwURmA+nyrb6ehqTzlMZxJbZtK6UHZuPa+OJ+eTbkVOBKaFitrgW2sO3Eo
         MIhzdOy7OrWKCz4OoCc13pJqqx5fSiEx2dCAySCmGtw57Xv7CLBcsLjxg7h+pfuQkz7P
         eNRVnkhccK3V7afO/ujr3dibDXPfB94RdnJ3i8cBm1KewEDGQsA/PXfN+i6k/Mm1VTzP
         gzwA==
X-Forwarded-Encrypted: i=1; AHgh+RqixK1L8yW+qO5KtRTPBaexHQY/js7ZyTYFZ64eoL4vcUok0oVsTzcRqa1NFdDB7GJxOYrd6hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4bJNXI+yQ32MwtzLMn3Gj6QIcp70A2rxFXMuQfH9g6AS3+XQ
	UO8ibw4cyV+lm8WyC3SS2XIzhrMxX9OODetRzvyS0fRWOsgdJPUaDpJVO/LIXc/tGtI1fb9XYa0
	QHEYGbAXDFoSpB4uPph4MzOAwcbBBmg==
X-Gm-Gg: AR+sD12PuacxIUtHWVgvomduXsz+AJvMcy6RXtH/oqWqdxcv4akAmiuzNjR0GP2Y0sD
	lhMHjkZDpGj8W916xchGiykfsH3kVV+ykPldNAc0t4Gk/L8XI0hSlY4HpRmSA79YbewIffhmpZS
	xcW5gkmLfuEC1GLI2McYbmoXe72lnjfV2WWpDFTOJl9mDGap9zCkcDN06CRR7ThwtpN1QgmzJ3y
	XtS7D6+mvrom5/yVXjiSFwRNEbQhxVVQscdI4ApFPk+3E20gay0AUsOovbblCOnwjqoLifsF+BE
	rV83Rhk8Q8Sb9w10X3aQ9K/qCzSdFXEzY9g=
X-Received: by 2002:a17:907:1c13:b0:c12:34ed:da14 with SMTP id
 a640c23a62f3a-c1c50b6671cmr294192966b.64.1784900075121; Fri, 24 Jul 2026
 06:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724051001.202741-1-hch@lst.de> <20260724051001.202741-5-hch@lst.de>
In-Reply-To: <20260724051001.202741-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 24 Jul 2026 19:03:56 +0530
X-Gm-Features: AUfX_mwWTg42HDw4aWDghBP51qdfXyDKkMoJixeJkgq6b4QcQa_tMbSOXy-DN0w
Message-ID: <CACzX3AvJUPUhxCPgqOW6zSF2exawYG_okkL3xAEd=s2g=EDd3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] iomap: don't free integrity payload that doesn't exist
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
