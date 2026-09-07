Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FD372B5A
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822045; cv=none; b=HvtF4uO4qFf2zCjY8sF62VL/c2/4cMPin/ot9H84eUD18Uopj0zGK468fL12gog7uhthKjSXS4D7AZLTVsT/LxfgWFBpq4U6vzeId1N94VHhMzEAIH/opqyBRjyE2yQdWZ3RDmUfEbH+aYguEW0N1bGSXrgvsotZ1getaqNhCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822045; c=relaxed/simple;
	bh=aYpYVmSqSOXjVdn3TjpCgs6bBpze3xWd5H+X//z66Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeVSHJtPdnOazwEAqUZPtZ+gv2S0CdUzO7VDD2u//jWFy4ByBSyqTxLJodk+2c7CKJd1DFLSk+/AeJnrBQwovLS47V/z2kkHkbizeLEbNxsJ6GQHHDBxdfRPdG3iJynzf23k7xWdvTOPe9h/nDd8k916hE9w0KJjXwKnsXzbUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCSpIpr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCSpIpr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7661F00A3D
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822043;
	bh=aYpYVmSqSOXjVdn3TjpCgs6bBpze3xWd5H+X//z66Po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DCSpIpr6WRXUctrVvdKBFbKkcCPfLN50pCmFxZvsHeKQi5z+TxtTzJxlBQ+KJDnQm
	 B3X7oNDxaDxgp3pxTMUDoDOuF4fhOdRQp2F0E9NRh62gbQm5cr5a0Yt1DutNVBI40c
	 9q+EgOo/NgOkYNaLpydGs9TiS7L3j8aL6u4S1c9MTuM2iwPsQgTsqAUwYXUBJOfj1g
	 7TOfzpTVS8HD65+VkX2UeZQIc3nQbZpU9i6CrJ4KG7pZH/9ViUhAF5m2LzVnYANCdE
	 n8zXMeUwPu2SrtkRDcABKbcZ24nbfAmlZdtQfsie8n2skxXf5cXQEY8w3YIDPDLMfY
	 CaP39fIB3IXJg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso647209866b.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 16:00:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5RC3VUQsBFl+wdYBxDDKtCkiqu+mm6qE5gFO1+E7N6aLK6SXY1/ThNZGGZRBUfs1G1ZwsNu4=@vger.kernel.org
X-Gm-Message-State: AFuF++n+GE8I6ZO51IqS4T82Sv4X+QlyogqAM1oWKhtjapXE76vkYoAR
	IEbiCJDXwai6PPESv4WpoOH3+qOu7wjEBzTXaqJ7GESdWD+m+6nshhrxxyQq3lIOz+lh41IlL9a
	IEJFlzS1BFbSiWNxH1MMWtj4oGTMr4vI=
X-Received: by 2002:a17:907:9724:b0:c12:b2db:873d with SMTP id
 a640c23a62f3a-c260c9715d3mr1634679566b.5.1788822042222; Mon, 07 Sep 2026
 16:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906200517.725015-1-pc@manguebit.org> <20260906200517.725015-5-pc@manguebit.org>
In-Reply-To: <20260906200517.725015-5-pc@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 08:00:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0fcfEcJbPiYvFWG1F7iSffsCx1Oxg+55vc=drmgO_5g@mail.gmail.com>
X-Gm-Features: AcwNN1U2kSONxG1l8mhUnSXZr5xC0fN0z0RgrkWxXOPiUDZIuoDlyPBR540tfWo
Message-ID: <CAKYAXd_0fcfEcJbPiYvFWG1F7iSffsCx1Oxg+55vc=drmgO_5g@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] smb: client: fix file type corruption in wsl_to_fattr()
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 5:05=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> Setting the file type in cf_mode without clearing the existing S_IFMT
> bits first is wrong as it corrupts the file type when cf_mode already
> has type bits set (e.g. S_IFREG | S_IFCHR =3D=3D S_IFLNK).
>
> Clear S_IFMT before the switch statement.
>
> Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40mangu=
ebit.org
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
