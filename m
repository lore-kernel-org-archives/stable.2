Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122783;
	b=1z3b8CXiop7PZqyxbWoLK9axT5YP/gQlcl33R/2/B/CGbKaw59RehEqSCOkwn1gg14Vc
	 Cj6OMFZYegZON87lLdCAwYywxaxPqZsfhqAFuHzEltTobi8H9WwzZR9viBON35x0sgLKI
	 L4/+eNhx2YJM89RXsdNqQSdOYbv6z4nPQY6BK5j9mf3RczxoUjcXH6HtvtoBEKFqGJwd4
	 iX1JjKZ5usvUoBKStwL4LRAh9oDjuSTGe4hWjW6m3YxahSPybvwIhokR0XehJrTFhkp7q
	 cEQvmWpIh+8pvT0RbfNd7+grXPLnOD0fWUVkveOtVNPmIW91KYskpw5aH8lf5i438wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122783;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=6x76b+dWNYkxyAOIg8gOhXeybtFLVzoJGX/qOoWHoyI=;
	b=m072z4lnUmsj4qp+XbKoaBoei5tW70OP/TzK9dtgjI+IBxnAgAQjcMemHzwXRHN+J3Oj
	 5Y4bxes8/aeyOmqWwXsnziWicWyphk9g76oDo8V1qXbzTOGInfQNwPyVofYRAT7GyzhB2
	 DS6cV85cnUf8oq8Cdin/jqXaPcPilSvtPGD0sNKZvRSuCzhZEU65x2XLHscaoXUKWaTW9
	 gr4XmLfXlOzozDGbNnegiv0Fe6q4VGaqc45R0Qum6snQqUMDYNb8NpeE4aG3m6uDAevBJ
	 hFzkcP//RRpjbpu6c9MBkYJgIDgY/nt1fS4PorqIanDDeC4iKLRu3ijVLb1NGMdUvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT6C3LZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B060A2619;
	Thu, 19 Nov 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT6C3LZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9426C1F000CF;
	Thu, 19 Nov 2026 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122782;
	bh=6x76b+dWNYkxyAOIg8gOhXeybtFLVzoJGX/qOoWHoyI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gT6C3LZE4MrQUZ/gnlQiLqeMH6XyAmvwpoyjlIjzt5f2G1bXxWFCtMjHliZ/rbQbQ
	 GhR+wjrKRW1G0FzBeoLAq6xd7mbQNSpPKaFL60f8pTEaQgpkxhyXioKRE+iBMV4s7v
	 5H3rh4fhUjXvKCR03n3I8w1m2jbyLJFGNyIkBLrIcEIm4UJSq0Hyd7QAYlgFgWrDJc
	 nB3NZAf0LdVYhPwwAMdhir4dp2CSEYAOBW/dgpcevWmpamHJU1IBbY06aQiS2Re5Kn
	 PZvOYHM/MNFY1qykks/XQg/9joe2L9OKTPTvex+PdKINTiAHLks7TFJrvD8xYdevni
	 bYvfLZQXyjefg==
Date: Thu, 19 Nov 2026 22:12:59 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
In-Reply-To: <av9lbJa8VlQTeatR@google.com>
Message-ID: <591122o8-59rn-p517-34s1-01r6qoq74r42@xreary.bet>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet> <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet> <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet> <av9lbJa8VlQTeatR@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Nov 2026, Dmitry Torokhov wrote:

> I think if you simply drop #22 and pick up Gideon's tested-by you will
> be good. But let me know if you want me to apply the tags. 

OK, makes sense.

I will still do the split of first 14 patches for 7.4 and the rest for 
7.5.

Thanks,

-- 
Jiri Kosina
SUSE Labs

