Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C937DE99
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204000; cv=none; b=dUJC20B5yQAnu2k8pdtBzmkbWUWC/MGfXDIVzNtb8ma9gm6mZ18oZb7oXtJjkKYWlBx3Tw6NNbUFuDN2C3uxBWTwOqjirvUduhZyNnW0TbHW5GtbRvyKbajl+OHuwsxF31yjHK9qwuZz62OFZgeEiP5dNWN/ocEVPW7gu00/r/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204000; c=relaxed/simple;
	bh=f6SO85nB0tbbSMqqeAiKBH3u5+yiO1wYPQ+PNjgFSvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtdqDS0R8stqp2F00/KzgAh9u3XdYdpcWlV6XA5XC8mUrduncAz3LFpW4xlVg6K6q5edg6bVUgC2pPf8ToSsNQfjEcADXBL0dvlq9ixicS9LbcdkS7mXdK0eT/NQ9khhybtLyCfVLrqfM9/Qq8FpaTORwI93hO+WvZVCAH4otEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Fj4N3ue7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fj4N3ue7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25E41F00893
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=Fj4N3ue7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791203995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6SO85nB0tbbSMqqeAiKBH3u5+yiO1wYPQ+PNjgFSvA=;
	b=Fj4N3ue7e7ithSiP84Zjsi3BwxNPw0aVRyVBsNYG5wN2V9ZbHrMZ6us26eQXgqJdCRC1c+
	Y9O2nXD0IWOFYdNyDRi9/K368o5tkv2wf69m3aYx5w3bvvIqrnUqqYEf+JacgyvXu7OMkE
	6Ak+HqO1xBrVoKzYWwXs3t40yhn/Sn8=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 7763a3c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Mon, 5 Oct 2026 12:39:55 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c315869241fso70229466b.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSQIXxYV5I4VGZSMdV/OuNU8Er3worAyTm9kRX1nNOOo2UyPdcn1Lx7WbrBGqwrrn6qAuFVoY=@vger.kernel.org
X-Gm-Message-State: AFuF++mcwO1pszcl8ZgfA5K7MTwm8z43bgoKt78/URtx50wuWwqEDMFB
	9cO7doH75Oz/2CIRGlTxhN5nXE6czie+So1hxEEN3138lr/7U2Ck2bQW6nwdHLBRFK5JP89KO2a
	RazcGm5GnlDU1Bz2J5MtwIKX540aVTOc=
X-Received: by 2002:a17:907:3f9b:b0:c26:19de:9aec with SMTP id
 a640c23a62f3a-c2e6f25452amr566621966b.43.1791203994139; Mon, 05 Oct 2026
 05:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825135054.54883-1-wangzhichen@manus.ai> <apBPSpFLsjlOTcxi@zx2c4.com>
 <CAAdUpzwZP7Hcsq1F7jQFoHu9nvD7R8P_tcdWSy3tOjw3f+BnwQ@mail.gmail.com>
In-Reply-To: <CAAdUpzwZP7Hcsq1F7jQFoHu9nvD7R8P_tcdWSy3tOjw3f+BnwQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 5 Oct 2026 14:39:42 +0200
X-Gmail-Original-Message-ID: <CAHmME9pQnx9t6R0SOAbEShbC5a-QrQz6AaHR9X4Rd3WGRqHGxg@mail.gmail.com>
X-Gm-Features: AclHuK-ZD09_Odvs3v5oMjaOxgimUCLI1Bfw-Q6KUNvv7XINwi4GVkLoXuYGefM
Message-ID: <CAHmME9pQnx9t6R0SOAbEShbC5a-QrQz6AaHR9X4Rd3WGRqHGxg@mail.gmail.com>
Subject: Re: [PATCH] virt: vmgenid: set driver_data before registering
 notification handlers
To: Zhichen Wang <wangzhichen@manus.ai>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I sorted it and it's in Linus' tree now. Thanks for the patch!

Jason
