Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9C4052B5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348139; cv=pass; b=Y+rXMPmv5rsxu0UN8b9Rp+kyacCexB1ulj206DKPdfU2mfy2I3fUonylQYhdeBIKCaiASngsJbtfzXlV0lvIlIBDEX/1A4Jp9JeRtG4qXfEAhrvoQSqBIfJQExnz6gFqgm4BMGAcuJ+/7k0THY9d6IWtkgshcU7LhmEMw1u8diU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348139; c=relaxed/simple;
	bh=I03PziP4dOlOedVu8wXVmPj70iqUeQLkkJMqOwbFVg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeFC/roEEYnM9YAP8fUGDlGnCFMzA5NCprvhkuu/U1x2y9iUe5UWx/JEqWlS6HVcEqkDonTSeBOJgzB6coN14MuW006XXR3UqWJeM954dIOR5dnPRk5iprAPd3MNCbijmwuk+GMOEStq+hhGxGo8MXHK5X0s4+H1dzZh3G2iEsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHx2h20E; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHx2h20E"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38eca09faa2so163778a91.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785348137; cv=none;
        d=google.com; s=arc-20260327;
        b=TjzTPg9v6AIT7MFG/op8DAHP73cIGt5YZLAQUElUVzX79Yqy1mL/3IFBXDmQMKA2Bn
         RWOq0sPgwgYWEtjd6wN2NsAmJqz8uQzcaAv1avSR/Yb/mEItmdOIG4R5xRqAGuDqQ82U
         iiHXZf6vHMcCDFTMTNJ8CRMazQ2pEWmp04aNhOh5D/t8ED+bYnTTDc4wrU6WG1woEK5S
         5ucCvyaG7gW31FGtLa12LaDHCJdwPMg4nW727hJOr0qkWPbdkrdz+NT+Xibp3hr1djEU
         zADB7Aw6GCJ5dGOIqkrXY427HaT534me37UwUcDwvDc1OJAvnx30CMGvyR/iUiGhbk5o
         5tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I03PziP4dOlOedVu8wXVmPj70iqUeQLkkJMqOwbFVg8=;
        fh=Lm/H054pZ2oH7yvScZzuOu3ExaJRBf6xnyuABo89OUc=;
        b=exgYiC7buJNeExaZ5GsVMZVk541bf/ewmumEY0N2/7I0UwWmX5ZD/d/0QPwoNZuhOo
         nZJND5nUmwU7xqWRjOK0c0UVRtC0egakODRMkkuqBJA9tWVRB6g9xm7qrzN6RyxpeFZP
         qVpkgCzhHHqJjzPu+fY8I94dbp33NR65SGYijQAFxccoIlk+am+y+MBrgqrs4+BObylV
         /CzlFvSx3WaH0lL68XbeOzKeEWnRZ+DBK1ANzHYWAoQmbZuP9QuSM+oDke4i4ymadDoH
         iv8Qrl8csWs4t6bdhPYquh/wYEUlSS/90SEEzbe2DG7EzJozCdDpx6TGni4e1kEe2puC
         nOIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785348137; x=1785952937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I03PziP4dOlOedVu8wXVmPj70iqUeQLkkJMqOwbFVg8=;
        b=rHx2h20ENojzwQV4I0m3ygVea5g96XDbTOlNcQWDCUjw8w0+czgef75tiqNJKcIXPr
         r557YA9NQzU/L7VYWSVF/MUUMAACLfKrJoQ2ohFTMCVwXw2RrVTplEchyR2ji8G3c4zu
         dCVnVpxXkH4vqlXDf0CmEuV2XJ0s2ItfFtGLE3u84DvMnnqU52Y+EpjXFVx6TUG8A010
         5Ywa6JVTTyJFavdzVkBjXO4H3z6clylXodvQ4EpwvtR4VKYWDy2Fp2fwl5c8F5abnfDV
         y1RrgcA3Cu8XNLJSyYj5gOnSOMTcUylMUsk5kfqVqosb57RsfAuxKvL77jnrLhvoZZ5M
         EmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785348137; x=1785952937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I03PziP4dOlOedVu8wXVmPj70iqUeQLkkJMqOwbFVg8=;
        b=XrLhpd4ps+nTTaA8fZU4WOHaKTQMLcvQ4Li3uudKXL/KdYF2Qcp9sGWssTwzn9YL6i
         hbHFRvRx/63XLfjoO9nYGF3wTH86LW3tEDptWqT5zfcBiKTFp8h7SdIzhKjNYSC/XGOw
         YgCVovIb9R4VdOTATi0gheoswz84a7lMtwD3B1U1M3oLnoV8jz+bXL2OxHE+nD1ky26Y
         D9ejqNMOBDPVy4ABFzCjJTNxKUsF6Pem/zn55h0YC2L+dkl47F44uApMvM20o7/wJ0st
         0nyNuUH9Z50lQ9pGDGFY63HVzTqKVlcg13+Aj7LyaH/qXcARAKmMIXdxTr0Qgc7z3TCq
         QRPw==
X-Forwarded-Encrypted: i=1; AHgh+RpskFNrTW+0S49VVDaBVIwWKlGRXDknmI35ivqfM//woow+57MdsS0ZU1oxEbgex41wfSA3WKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYK2qajGBaAMaccg4yNtu76HmoAAKjsxHTISc57Mqf50cTqEB
	HlQkkEnHMjKGfar233HfYoVouIoJV5BXSB6GS/YAoHIHeDQNFeHAVnIrAFYkhs45jbY8HqIMfHo
	IR9ttvZ7TqTmWrWZqqXeeF/auY26f30Y=
X-Gm-Gg: AR+sD12+ZDekZRE7QX7ewKeqzC9QdUKZ9UHyS3tor9NHkfeZbTmyAoK45mGdr+zJLPf
	rnZbYaUkjE0Vg4woWUHaCEIguUjLQ4YKCR0d0FZ/OK06dZVtVc78svOQa7ik1tUWLkujv79Z5OC
	6hU7TQ9ek3YuYfgG2koHxZUogy8qqx6d78RZFdugp/opDILruWVwCR+9U4i5DLCnbhzwJ+/ABy6
	bbMOKqaxZHS/SxUPi/fg0q66Lhc4ezW17fGe70ykhvF2ZqlM6JOxtjgoNRW7UFwfujftLRD/H9S
	Kp7E5KfKO34ZEc9WASgvBzrMyykXmN4/oxcxBHaG8psnXvdyaKLOqtjuq4RJqA7jOtX+EMjNO19
	HUYflxc0J2MTgTgeZD6fq2KKtoqwB29kTtVw8QwYuCBIBaivS1CO2i31KZho2Bg==
X-Received: by 2002:a17:90b:2f8b:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-38f7c7274fdmr8016133a91.1.1785348137075; Wed, 29 Jul 2026
 11:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026072907-spearhead-karma-9b2b@gregkh>
In-Reply-To: <2026072907-spearhead-karma-9b2b@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Jul 2026 20:02:02 +0200
X-Gm-Features: AUfX_mzYDB9lXly60GeUZjNkJxHkvqBDV5BuKmDqWs-PkuwqUgL8qcOQ-P3apr0
Message-ID: <CANiq72=vPfXDGuB1QY6uwHAdOVYFZwKm4jZEA5-gGX6rak3a1Q@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: device: avoid trailing ; in printing
 macros" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, dakr@kernel.org, gary@garyguo.net, ojeda@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:26=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> To reproduce the conflict and resubmit, you may use the following command=
s:

This one will likely not be needed immediately since upstream may
relax it again for a while (I will double-check), but it doesn't hurt
either to get it cleaned up already, so I will send the resolution
along the other two.

Cheers,
Miguel
