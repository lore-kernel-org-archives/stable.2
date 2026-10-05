Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9E37D12E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187022; cv=pass; b=leNH1KW4sSfIytHVpV+jZMInFaBVvpbYJAQna+d/A0YBtFJjytuZNBFel7Z6aOL6XgNRXcxHLbe/HGUTAvhHZLRjDcKK0zJqXOf6lZQUGT9DJaDz9TUmGqoWCaA0CqXyHqsyVV9bwPeEoE/hho7giwYkG9zi4PRD07WY31bSMxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187022; c=relaxed/simple;
	bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvlh5Eg8DcKbU1EcdlFGibBRoGN/1U6SuuK4oFykiasieiZYoU4G6H9VCIlDHe4z2Qe3c5tsfPvdAJAYI/56qzORt3XFXmOtSyvWfK95swvkg9uym80BuvC19mnhB82iB721V9QCPf35dNIUKtyvk18kiFJGtbNsGKKogw3s/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdFTF936; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdFTF936"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fe8912so139134a12.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 00:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791187019; cv=none;
        d=google.com; s=arc-20260327;
        b=GGy63BTER307KNEw5AyhDddmJZROZPFiTJiPU/iTCr6twY20xuCxsGT4hq923T4Y2Z
         sq7Qt5oMG3E5Y7H6pqdPZBOnC6eyGIsP9L3s5SVxpYWghSAJyTiThCdrK/ZHOo0FrnPa
         O+FlcNMnc4P+WfmDeyb4FKfr6l/5JAl5ZucvRFI8othpExCBzfJy0ARAdvygW5vxYL5H
         kpC+dcdEEg58QEBvsjv3tLxuVNZM+q1wtHYB3BERWSRIs6kTMBhLMAAEgQtlVUaFduLn
         nz28CIy5NjIbpyOR+e3okZlZLxXNAb8DBlcRo8oAmj6Llpn7SYF7iikddt2mvgJMaPGW
         koFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        fh=l5Xx2A6PQxmveGREqW5MX8hLsR6ac5+k1b1tOSeJPqY=;
        b=SH9DWQRWcT9L9gRYzW8dAwsxEIBodmEN8hmQciwoNJIjCOPNduZXjZFCJb/ytrQvkB
         ux3s1F5aleDfJ3HKe+xx+mZaJ/LrePcu3CUDcz19rqYqf32CetE3VeSxkMN+s2LYCSma
         Boa65/t9UAQT9DFz5gRxy9daPl2oAIQ8RTOvL9JnRKrOCo1da48Kqiuyox/ILccv+tYt
         FlvXUCtT8y9zRXQUAV/JU2t9YXT2WMbRaawEeGvi4VK3etjhQXRvSYjSGt2xY2njr0JP
         OW6IBygoS7Ds7XocCtOS/r/7yGX3+qM1ylH58+Zqc74lOnAQR+Tink1XhuzE8pw7J6A6
         gy/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187019; x=1791791819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        b=NdFTF936OLuM/81O1dlM+ND24KqVqhozqAzWRiQFixsNqqaeCAd3FPwgM9BMQEv1Qd
         VlwakQ3Jbexah13atoyKeaBwMHoFyr+Pt409dWN8TuvbyTo5MosAQR7DrhX1z4JFNzox
         6VIlz2f8MXudLIrFBg9pWKeBBD1tlb/PJIbT3dG4+kzIaft/VAYXVpXLrWo1fml1ighR
         ZzLVdexNT3AFUvcRK8/piOsjRTQAhRiloy8BrvPG8xi9n4Nia9W1CbrAq8BPZbMdSQI8
         U4SBR/9zsyigUNMkoKoYCfKC3KRGSY9qef4Qq4z7AJiCc3M7TXr2dHrVejzHG8o85fEL
         PhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187019; x=1791791819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cqt6Fu+sk8V6mLKmZzliQOQ130R6uksTirlfpR1CVrU=;
        b=Fv25eDCSrJkqZAcQ9+t+ZoNFu8r+neGXjMfz++3F/56Ik8FSgOAsaRTNs+HaLF9s5C
         3dNrbrjGebGTgcuiD2p0aXUEEshSKTnUMEoE2Ajj77mkUGCTxgP3UX0VEpEwRIpOkeKe
         rwLAFu9zZS5RDvSFrk21KTrzKjcLlCjtku9TokYKzBiV2dqXLdd2GKsqPILX3r+3iN5J
         wI5VDxsK1FrFlXR1sIBcX1vmJ6OLgffoR+fijiUPXOc6vHpL4wnoKtTrl6rCrl19L3w0
         0RlI2GligKgx4lyMO2LBaNsantae6JnjMJE0ixOA9RXr6vsYrUZgNc1AGzmrdN/3KsZY
         +lmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcSKYuT14Ss5Hs0DuASiAMJX1cRWBfxFWO0d8MjzT5scCkmo2XFGwdBaxOHPJABxpvT+YIAgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKcOch7rk4PVKMKlRBHQUrCv6Fv+MWorWpQpWoz4KE3utNCVn5
	H/D6gqCvZU1yZWnR/Su6Xa8YZnYbNGY7hSpX/2s/bHaCFlaS1k/kH/vlZFo3WFfGQB2gcc3V9j8
	+hSJP6eHK6aSzwlTULP3a6k5/yvQ36Zc=
X-Gm-Gg: AYBFou38Fh/ZH4QTRlV+VHEsg6/9bWlVtXW6QUd08dhpAwsqXKZ3DMHKpfOLIf24ioe
	HknNEUovbMu8SCwF6RxnHUaVEW+TCoq4EImVJBPljbwR2W990qWycuJe9bzRnPH3qNkLStxXz5p
	/+uZjvlrAplJCUJyDRk98pZ6j0CdHflXFQ3kzdOlFULqoOEevF01849uqcCcd9WJzc3YasCn79r
	FmwXRrDwoQsDAsuds1F10LX1d2FF/nz0A5rosYirZoVFFVXQ8Mu6/EUxQDbplJrqqZDlgQIvW3l
	MHYtkl3vpHj3jqCEdMgIFNEpgKFi1CO3xaoums2J5kPNcpJ3sbW7GnhGT+O2gb13VhPyQVV8WcY
	GWJHrl2+Fhm0=
X-Received: by 2002:a05:6402:3228:b0:6aa:d21c:9c18 with SMTP id
 4fb4d7f45d1cf-6af9e2f9d57mr8176215a12.3.1791187018776; Mon, 05 Oct 2026
 00:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004162458.3968546-1-nicoyip.dev@gmail.com> <225d8d84c8e5155d5af0adfbea270eeeda326021.camel@iki.fi>
In-Reply-To: <225d8d84c8e5155d5af0adfbea270eeeda326021.camel@iki.fi>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 15:56:46 +0800
X-Gm-Features: AclHuK9vopQGKPch616H4XPEsAiU40667tZEfF-9543oK_7dTTKxojOLxqJFuSY
Message-ID: <CAAo+4rV9B=QUBAWZfpHL_W8jCoCLTqv79kha6G-x0UZP9Swm_A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: Serialize concurrent connect calls
To: Pauli Virtanen <pav@iki.fi>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:16=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2026-10-05 kello 00:24 +0800, Chengfeng Ye kirjoitti:
> > iso_sock_connect() checks the socket state before taking the socket loc=
k
> > and drops the lock again before setting up a connection. Two callers ca=
n
> > both pass the admission check while the socket is open or bound.
> >
> > Caller A can copy its destination for route selection, then caller B ca=
n
> > replace the socket destination before A binds or connects the CIS. A
> > then uses B's destination with the route selected for its own request.
> > B can also proceed after A attaches a connection and sets BT_CONNECT.
> > For deferred BIS setup, B can bind a second BIS and overwrite
> > iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
> > back-pointer stranded. Concurrent CIS connects can likewise replace the
>
> Memory safety probably should be enforced somewhat down the calls,
> likely __iso_chan_add() should reject adding a different iso_conn to sk
> if it already has one, since that looks like it leaks the
> iso_conn_hold() reference and the back pointer association.

Hi Pauli,

Thanks for the review. I have just sent v2 with the check in __iso_chan_add=
().

I also adjusted the outgoing BIS and CIS callers to handle conflicting
attachments early. The BIS check prevents modifying a reusable
connection before attachment is rejected. The CIS check releases the
HCI hold acquired by the current attempt on rejection, while
preserving same-connection reuse for deferred setup.

Best regards,
Chengfeng
