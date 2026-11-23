Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463150;
	b=sxQACR3rQVqQrxBXZ9PoHl5ftJCVqaZOKGYLFuMCkwzMogsqqbekY9Auepi27ygTWcFL
	 xLNPWyVNIbKoKmXukEEfIL0fpgScIv2APOz9SIzF+jBiIAkVQlr0Yd83g7XkaD/JmUGsx
	 mfJ0g6tccp2pZwx21FkvLUsz9b5QvwqWwy4tDv7h2OnxC8jqZzo8jdILZofhBQbgob1Lu
	 GdlXVqSVQ7ScPXNcCvjww1AcTBsIUyIdDpgpqo4MxgEjS6SGYUj+0abIufdO7z0zVBueF
	 q8uCtSyYzUS0wYvGl2OmN0klG8dTP4HEu5LOjMLjdF+kgaqC3758s/IO9eW3hWZyrFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sWpHDwX4NA5FzsiIsGJw1W8t/+RBE5s4GsO2WVDVB6s=;
	b=vgl/n3s8WAsEXa70awPWEQ97Phtfu1e/K3gN6DywOUFxvErdrShnDthrUuiAxBLb3QRv
	 JjuzGYEXVZTdZYe/9Z3nU1Y4uidihInH660vYw0p4yZrlZXeApYd2Z267XmQ+orq7VseK
	 BxyIQMa2gZcaWdSZuIdLjRz+wSaP/jV9gU3xAKKFM0Jgo92W3jf8U0Bbak9vv8eQbvi1y
	 swEurIDf2mi/Gc6qZox/5mT0rh+jmA+5vSXCinFOQ31iFGgZkoVSqYG/pD80I+of/1J6X
	 VO5nPzsWclP6bolZx+/4TlkO/4iG3qzXrGGVYjWF+IMZPBi68rEcy0O/H7MOySmK7yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XxWqDgBP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C7606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 504C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XxWqDgBP
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-862df509ccbso1919361a34.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:45:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463149; cv=none;
        d=google.com; s=arc-20260327;
        b=lHPHyzZU4MD5OtHr0xEJwCM+zmobRiRqFH36emjxWAtsklf9BGVGz6IXxuaCLetOaB
         uENSfIYCG1LgH/WJAIEaWGEWUrPuBZ57spYJWAcjRiOw6/6IO13PdR4IgpdhzrXHNERY
         dWufUxf3Uaad13+rmTqOgG94kQFI/BXHq/MTis7FcTpyt87ymWTzvdw9WAQfJMLFswAf
         TCEufV5FpsQ1PrXLFZsmt3Q+pcgtjaRONRn7LslnVDjy4P2LkLLstz9LkciurmbGcNlZ
         Sle7FJ3tLfV5H8PvpvYHRuLjTEzdUp21ZSexQwJ1maM4SQmTIGu5eGVMNsaIz5ju476c
         Fd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sWpHDwX4NA5FzsiIsGJw1W8t/+RBE5s4GsO2WVDVB6s=;
        fh=Pf/V2pE0N3a/c/9LKDfCEkNrEhZoyemAsqZsev1wzJI=;
        b=iIyzX74V5VgNGuRfmEcLHPLFI3ucXCpGx83TG/JQd7tI5Sb/t1KuzB2BoDsB41+uLU
         rGf7JaWj+pFSi/Gtu21g0cNsplCUUyiDvAHLtYJZ5qGOJZyTkh3ccYYic1R/DV+wwJRg
         ZyPj4THOm6bu60qhos5x/kAuaTHD+xE1U0hpZYWT+fgZ2XmffInv5C0EEUiVA6XCrzkE
         RJXeDV3ILYiaOlGgDqnunYYYNL0n9n2wUk25G4wUcnolceNy76Y5XNBw4JGLb7CqYDYU
         rP7H5UIoof4VaSGRD6pwItkwA/Apmce8moFgAwffCIGWF+5diYSRIVi90GKSmgAulRs0
         oTaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795463149; x=1796067949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sWpHDwX4NA5FzsiIsGJw1W8t/+RBE5s4GsO2WVDVB6s=;
        b=XxWqDgBPvOrPiG/JBS+4vCjVp1NJOTBors+acPB6futXqhRKJs6jnkSn75nYG5gc3O
         L1rvc8WB/k4tGD45bTmzWQMdmgOE0LuwDMyP80KjulnParY8TP0vrdbmTWuWuevwz0It
         7zQtYWLGXqcShfdpszAT3/eZbQRnjnc6doiDcROsUs59UuV445wqCFPKKje1HzL8OcRc
         jOOPfLbHSor81vSdq/qz+u4cO8gJHkX6Py/w7aksmfZAQQVnFfR3jcTblBwsrKM3h5E7
         dEoS/Oz5d2Zz5QEYPiwN/O8NfpQ2V/GmdT+OOn+ac2KPMsBHGMUUNtVala7+uF5027bW
         7+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463149; x=1796067949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sWpHDwX4NA5FzsiIsGJw1W8t/+RBE5s4GsO2WVDVB6s=;
        b=jhdpCGoPFoia/Nh5KzaIiKuKg3LKbCWuA9D2mQKYT3lx0BZcl2TbP9jstvhPG11sUY
         hOCjbY15V03TZISA0bSfm4B+kkNQVwYarS7BUurQD86Uzoj5LiaSSy1Iq3z1DZLX0v4F
         424AceCrCCtzzhtGiryMU2sdk1rMyK6QG9nmFGNXuhIjsTIPl4a+rQuSGxj+IE9+meOp
         97KBhagMZD20skgpcFANvoSa5nO/C80HSXpQkq14uEZN61HtDWm3wBktGE8gwtFYg8fy
         C9xo2TsBpD/tlMIM+99KoQaA8gKXaH1MuuPqlN8+Ul6RGF99YJR5o7x6/C+kSG13XI10
         E59Q==
X-Forwarded-Encrypted: i=1; AL+hErHpAHgnWNIPg3ddhXvL+meUD3vDUJKcKuIFNc+qWNMCHDJKxPIJ6F3w6SYPrrKB2DQOfKEYc2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/eBi2vfbQ1DCFtKaW7CLuVJrH/XtRCGgayzYTcBrEfMhPTP01
	SU+R1igWxSxE3A/kbJ2kwZbZmAfTaT9ZGjck5srbmNT0vC25oXHKgJ+EoHffNRSgJuUEHLMgCvV
	SBPrmd4UgDchjOzDzR/HRHClRPewl1hT5CwkYhwClha2Bt4nFzIK2utU4BG7GcQ==
X-Gm-Gg: AZFdTZdMfT+DgycGj1JFD8mTus9qjHgrnA2/YVEY+3JRdyPLDX2ofuFI6ZTA9i7k21o
	wkewamYA35RU/nXIUhRXQ210ogsUNXzkOVc+ku/mA8yd+UohKBpycyeoSOyx494EVE9L9mKlwvn
	Yputq7QwUqyS3NxupB4FRdwXqPxG0+MO/GU5EMsxKSowv+LtKdeAVRclBxV96bk6JmIUzLuIlfw
	Swd6fOKR8/oFeRHgBqWEDqjK9d7cSpoC3+4bZOz858Qt/4E6NoAofvODMmNft1CcxccMCrm67M5
	PO/FIFhLoUjPp3h+czKwZfLBU1jKT4Jwuu3sywxA9PGXRXL+1NuM8BMCkMR3dtSbc7c0XnEzKVT
	sf8h9D9b5xhq173I6o59KQP4zmE8MHc15ze22m3sUZ+aCz9lf+bKbnVGBCk3UruTKc2HxA/8=
X-Received: by 2002:a05:6808:4f26:b0:571:c073:74a1 with SMTP id
 5614622812f47-57a06b1d98bmr13253520b6e.6.1795463148513; Mon, 23 Nov 2026
 11:45:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net> <20261118-tcpm-soft-reset-sop-v2-3-b6decdc95e66@flipper.net>
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-3-b6decdc95e66@flipper.net>
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 23 Nov 2026 11:45:36 -0800
X-Gm-Features: Aa3M54qeLdW7__eto04IrOjIag6aN2KwS8X5d3xJpM2jc3XAmw1IIHMMRYpRwTc
Message-ID: <CALzBnUF82EEAOaiPXKQaYvOYQkthpBaD5z4maKf-bupuuqHzog@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] usb: typec: tcpm: Leave SRC_VDM_IDENTITY_REQUEST
 whatever the cable answers
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 17, 2026 at 11:27=E2=80=AFPM Alexey Charkov <alchark@flipper.ne=
t> wrote:
> @@ -2745,6 +2745,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port, st=
ruct typec_altmode *adev,
>                 break;
>         case CMDT_RSP_NAK:
>                 tcpm_ams_finish(port);
> +               /* Go on with Source_Capabilities, as after an ACK */
> +               if (port->state =3D=3D SRC_VDM_IDENTITY_REQUEST &&
> +                   rx_sop_type =3D=3D TCPC_TX_SOP_PRIME) {
> +                       tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
> +                       return 0;
> +               }
>                 switch (cmd) {
>                 /*
>                  * The cable is not allowed to respond with NAK so this m=
ust've happened over SOP

I think this section can be combined into the switch statement below
it. The comment
states that the cable is not allowed to respond with NAK, but given
this patchset
hardens against non-compliant cables, this can be consolidated as followed:

case CMDT_RSP_NAK:
        tcpm_ams_finish(port);
        switch (cmd) {
        case CMD_DISCOVER_IDENT:
                if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME) {
                        /*
                        * Not expected from a cable plug; carry on as if it
                        * had not answered.
                        */
                        if (port->state =3D=3D SRC_VDM_IDENTITY_REQUEST) {
                                tcpm_set_state(port, SRC_SEND_CAPABILITIES,=
 0);
                                return 0;
                        }
                        tcpm_update_vdm_discovery_state(port,
VDM_DISCOVERY_CABLE_IDENT);
                        *response_tx_sop_type =3D TCPC_TX_SOP;
                        response[0] =3D VDO(USB_SID_PD, 1,
                                typec_get_negotiated_svdm_version(typec),
                                CMD_DISCOVER_SVID);
                        rlen =3D 1;
                        break;
                }
                tcpm_update_vdm_discovery_state(port, VDM_DISCOVERY_COMPLET=
E);
                break;

If a cable can NAK during SRC_VDM_IDENTITY_REQUEST, it could also
NAK during SRC_READY/SNK_READY. Here, we can advance the state machine
past cable discovery and prevent SOP Discover SVIDs from being blocked.

Best,
RD
