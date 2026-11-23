Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462246;
	b=2ZBlt6GFxMW49Na5/Wnja9OUP+b4s02RoP4P4BbTGWibUuQ8A7vuOotEidnxgg49YEdm
	 Bo5946xQD4w1DYvF6m7mb7nPoSf+zGoEtmZLy6fS959Tp6F152f2yx3LgGkB5gFcEXX9b
	 T1QhPjxI9v7mud0Y2KZcJ3ykw6kxidnW5CjyQpJzoBehqXPac/sJIJZWHG+gsPawHaxG+
	 MsaOCdC5Jf8+a+7R4DrVw91VYfTLrSSRL0LBaOPnE2TvYgTQallOx5nN8sQkzl9OFjQf9
	 Mls9ukghPNQcZPSlvXEXGwA5eECPsAM82EHmBnSIhtTMb96KvCT1uYWml/w7VugOKuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J9HL1GczKVUsA0QA3fywXb4GBtKWVrrqUMxuNy6hTvo=;
	b=3oE6kD3QgIZYHBLNsdDv/J920jVyxchKs8TtQ6f/M32UO7VQOwEOZ4oSa9dBDQYXcIFK
	 jQCRh2S3pjDN6UaEHP34e/WjYNGXNgNCLgyt0oukB2Z/LY9BidbLu4NBu7vLyKS5eUchP
	 bnTEGNdVc7Y81caDplXD5hnDmLOgQcpP1wa9VBjh4fnn5X5BzEYeGDz0wmCCfemlEXySV
	 opWE7q/nDvyZUDG+j0qG+Wd0km+51SU8dk5lCoUni0S/MFN2FN7v8TjfwKbkWh4EI2xj9
	 0QJko3dT9qaNummi7ZsO3eKcms4nBkN4pTDo4Ekk8dUghytHsrVjiFPWNgtnF1TJqiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LX7QH62p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016F606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F016F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LX7QH62p
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48ed188ee81so2076040fac.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:30:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795462245; cv=none;
        d=google.com; s=arc-20260327;
        b=Ni2YyYTl010xf3/k6hVs6rkeG0VqCEmmrJCaeITpnFbjjhLR0thYF5J0RGd2zY0+88
         JEa6Z9Xxq5zK7dKWlk8XgOxOH+YY+1ni4ImVGUSteT45lbdj0CH4vS89VqNf1FSfSYUe
         ovCSZFH8XCRtvIgi1nHyb41Iwne3rDcpq811gUrEO8RqUNKCb1m5Mwo7VqTPMv57RFVn
         KOWf6U0qnaXqkIU/q0glAlwGJs6sShTbWn1U/eW/MWDF2VGh8nsNTYVkP1UVdcZ9n0Gv
         ShvS+SSsRDRMPupvNs4dY1NkVVuNZ1N7b5TLmk9QZIZ2p9J1H/VhyJUr43HJYPI1nkIN
         GDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J9HL1GczKVUsA0QA3fywXb4GBtKWVrrqUMxuNy6hTvo=;
        fh=v/9e0ba+eKp20Oxo6zC3Rgp53bpKuGX74wleHOmKnsg=;
        b=IVf9KHYvgHuONnj2Plv19NnSfuZRJITpTlt9A2eSQvo8xxtesEXMA+6oMla8NsBXLo
         i7tC5ytVQZSiatTXK4A1oVnazfqjsJ+4WsG325Py9efBNfqLe5haRErbvxPGaYy2evMa
         GoWYvWJayHXor9wDFcIhduRvuE+zF+YRrjnBPH+2+ovLjGvFDyIMXj7bmJAfOua5x573
         IfjbUUikxMwPPOEr4rOT/ytTD2BbOBPRpZu7PkMaVzvR73QO0fXFNS8KEYH7wpSCvci2
         F30IjkygTynXGZu8i360B3KLPRbEc+SMnLUbyZGcj8UAxC7fq41gQUgBhtqE37V0e5j1
         oNfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795462245; x=1796067045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J9HL1GczKVUsA0QA3fywXb4GBtKWVrrqUMxuNy6hTvo=;
        b=LX7QH62prvmRprt/KaCq9l7RUGR6MW5QPJJRl61OtL9JZQFCzVemgNCE5/g0zL8QA3
         f999an+hMoSgV3yCdYEDsjWBG1efjI0zhVgaula8605zPmxBBWyw8R8YFcHa2lDZAMR1
         DsJQLQ6Hg2drGs36ASq+4NBa19k0wLLrJ5fQbP7yJ57dr8XFUnRuzHsfJyQJKN2S+zbV
         rtB+rwA3ozKbzon3ArK4+dZTP0f6rYHfVtPpZlD5ui6pd/jfHfgrBp1Jcq1oGjy1YJPJ
         po1ZPCuJQkuZCjZe638cDwtA98thIZVY/1i/0y2eoWEMJflJG41uxzMo4bGhyZ+9SD1l
         sIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462245; x=1796067045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9HL1GczKVUsA0QA3fywXb4GBtKWVrrqUMxuNy6hTvo=;
        b=HhxWyV9Tr1PUuaoun4+tNabgkUIm+hcGZzqoQI8TsNnHgZrznTdcHqii+blimAtMvX
         1YqyHAg8hboRRA4jDhUCnuPvHlt3oq2ZnumNi2feVMCD3WPeadRkOParg1yk031b1tim
         iBLq6G7IyZFjQGIwzN7gEMw+YQ6H4bMjveAqj/4QHdNQ8HPOCjo3sEk5gIJvhd9CPdrd
         LbS1Rl0gB9MCTuGsjsP5LwV2zh/1rQ6APhRueaMmWZCKR/hFeLXbGMSNCDs+ULqqgvlX
         BZq56j7CWZ7X9ztBjh4Wvh7jHxIAj27xcpPBg/YXYrkyY4mwxW2TUNw55pEPZzKA74YI
         W/gg==
X-Forwarded-Encrypted: i=1; AL+hErESTnRhStGJl8u7sSF/cgUCkGo/kFUUzA++O3t+fVW/tags4VSdzSb2WwwgqxrgS7ZJXtWkRgE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l2/zf/XVpz0Lu84EMwAyhJ4kOXFquxQFkHUwXEinNG+UI7fvt
	BST24sMYexdGoFMKaMY93CaEbO9CNw6xo3VGSLEJHZ7gRDzhsIjLdH7CYralSSjqXv7Nw+K51OI
	zNqkYvbVCxKpoamz8ALvXCEn9mFqwQCLlHzy1ihK7
X-Gm-Gg: AZFdTZei2fshIaIl/IVmQkpdfmRwOYrysHTIbJ4iKwbCPHG37iMFwMRiCrUP5D8/73n
	+pIRDufEbzvHdoIIY07xxVm0pUUhXPMYnT11XKs1M7cBwa6HMmzDNm27ww04zmAyK+k2QAYmYJA
	EYIHYfTK0sDUCgD1GTkp2R36y5YRX3ICqPU+0qPj5WGnj0nYmnku2U5wHKFHKUeI5aOgbDEoR3D
	6ZgTa4uX6CqRsj6V2KRPlkx+CigE8hOI5h/6frgkHTfZCM+tBdp0fUSo3xJ5+YeCwn6C2IYBrEM
	0sZGEIeI+ARg9B8rDVMLPr5iWjSM4qTIPOc1dIKo3UaNRTSI4reuBId4ao3u3vEvM5r7kT2U27q
	jFSudHj0dJRB4nltkxApOh87/N0Qq0+PznejePTWAwiGdw0MDTaSgia2r0L/IRromtYD+xGU=
X-Received: by 2002:a05:6808:4fe1:b0:575:39f9:df7c with SMTP id
 5614622812f47-57a06504990mr14041604b6e.2.1795462244324; Mon, 23 Nov 2026
 11:30:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net> <20261118-tcpm-soft-reset-sop-v2-2-b6decdc95e66@flipper.net>
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-2-b6decdc95e66@flipper.net>
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 23 Nov 2026 11:30:33 -0800
X-Gm-Features: Aa3M54pUjC99HdONKYWzXGaM6Hr8ZpKVX5kohDQnv5pnvvHDaIrSDaIDtVLGutk
Message-ID: <CALzBnUGpwPWo==RuFOQwT11CU0XKvCHhU0ur2e=DgTfCqOY1sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: typec: tcpm: Stop replaying
 Source_Capabilities after cable discovery
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The patch looks good to me, setting port->upcoming_state =3D INVALID_STATE
out of SRC_VDM_IDENTITY_REQUEST also addresses a preexisting gap
that can be added on, or I can address it in a later patch on top of yours:

Disconnection during SRC_VDM_IDENTITY_REQUEST leaks
port->upcoming_state =3D SRC_SEND_CAPABILITIES into the next connection.
This could mean a DRP that reaches SNK_READY following the leak will
enter SRC_SEND_CAPABILITIES.

This would be fixed by clearing next_ams and upcoming_state in reset_port:

port->upcoming_state =3D INVALID_STATE
port->next_ams =3D NONE_AMS

Otherwise,

On Tue, Nov 17, 2026 at 11:27=E2=80=AFPM Alexey Charkov <alchark@flipper.ne=
t> wrote:
>
> When its first Source_Capabilities goes unacknowledged, a source that is
> the VCONN source asks the cable plug for its identity in
> SRC_VDM_IDENTITY_REQUEST. Entering that state sets upcoming_state to
> SRC_SEND_CAPABILITIES, for a message from the sink that interrupts it
> through SRC_READY. The ACK and send error paths go to
> SRC_SEND_CAPABILITIES directly and leave upcoming_state set, so the
> first SRC_READY after the contract sends Source_Capabilities again. The
> second negotiation can cut into the sink's own Discover Identity, and
> once ended in a Hard Reset between two FUSB302B ports.
>
> Clear upcoming_state when SRC_SEND_CAPABILITIES follows
> SRC_VDM_IDENTITY_REQUEST directly.
>
> Fixes: af8b627046bc ("usb: typec: tcpm: add state machine support for SRC=
_VDM_IDENTITY_REQUEST")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: RD Babiera <rdbabiera@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Best,
RD
