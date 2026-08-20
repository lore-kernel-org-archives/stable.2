Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A7423794
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224584; cv=none; b=JcPUq7MAr8i/W8tYkv+aYiwo+cYApezjfTMe/AoGKOb/yec0log79mejErZMXIePinUyIvnzVocYcA5K1AhPY1BQ5FBgeOekwnFw5PJ9e1rW5GKDUT7fNiWfSkms/hgmcxna5BnmlWY5npuC8ybEy98wF4/tGPb2sxymE9Fy/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224584; c=relaxed/simple;
	bh=q6HQq+I9dQfNzGlpu1zi7Sq070BAgcHm4FdYtiPdPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCTWEopx4wcqvtI/PdW8UGzh5x9hRjH5ixVCECY3D3egCWdM3ze6OQR8QTMC91/6l2IEmf1F16ez9yLeiDn/MHt/1Hux4rVDI+/WmeLczmTka4sOXYd5qB0qeMWjVoPka/AANJyVjojtNGXFj3LOKoM7mDbiBW4/lv8teGnxI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKbIN6Az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKbIN6Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99831F00A3D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787224583;
	bh=q6HQq+I9dQfNzGlpu1zi7Sq070BAgcHm4FdYtiPdPBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iKbIN6AzmnoOXelz1e5RqMylL2FVAYbAleZQd9fDS1elv3HcihDHhly01ePPN/Wdu
	 3xmAeSL+M3l3Pz3YruKyXV1k+jZsC74IG4mn2REE1RIJznzuYerJTF8bpA1z6RASXn
	 ImqXqvRXMnHL92neafPHO3wrBjtpDEvJmk1y0QtTaNuuUFYEwrmCdKhRoTym7Jj0GX
	 f0vOeujMg7ZhlNR9tvYCjUWowKr0eZIv/Lcu8q/cXqw6+khtj64HCAt33wizcTQgEV
	 riVakOBUNOBxXpXAaYsk59trUk2pR5CinEX1Syith56qWKlylGHmvcYy8jOm8oil+h
	 G4PWu2xXeaAOg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3523260a12.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:16:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqR0ResxhFPZZPfAaAkmaDkpptykhXje0Ma2EHT+Fx4XhhkYCgfBnNfKHJrNWRrCebXy6rHRDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8vu487FQ+YjJvZoggco6jHkBvlJ/TdDW33Q7L/fNOxJGyqtH
	t4V5gDvov6c5scQudyXXvM1OF13CjgsVCU52h4e+SMPUYRNLv6107Ng0goKKxckTFHFU0tRpNpE
	B7Qhbx8LFvE1jtHiO2e3LPM5FKDR/BE4=
X-Received: by 2002:a17:906:7949:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c242e22dc77mr863348166b.14.1787224582224; Thu, 20 Aug 2026
 04:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-fix-empty-mp-v2-1-5d3367048b76@gmail.com>
In-Reply-To: <20260820-fix-empty-mp-v2-1-5d3367048b76@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 20 Aug 2026 20:16:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Jp393dq5vBNW57gkF6m61Ov-s5Su86t1DSUo5zVZjxA@mail.gmail.com>
X-Gm-Features: AcwNN1XWy5tCl9IZmBwf9H6YcLXocngnzDD8PsgTJxw_rNLDaIjOjLD2tiTLPv8
Message-ID: <CAKYAXd8Jp393dq5vBNW57gkF6m61Ov-s5Su86t1DSUo5zVZjxA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: reject invalid empty mapping pairs
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Robert Morris <rtm@csail.mit.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:19=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> Reject an attribute with empty mapping pairs if it has inconsistent
> highest VCN and size.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/all/9519.1786907182@localhost/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
