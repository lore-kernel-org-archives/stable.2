Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAB175A86
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783131146; cv=pass; b=vF9UahSbtUGgJPq36v9Fkc3/+8mRV+ae7/++MsnIjFr+CX60UFI7v94pJfITW6RF8eiAJxDLE9kQTgcyX3AM2x8VRJQGz/Y8MEx1pjBWHNrwy1McAmOut5qXi22BZPAr4l/sB2FK13sQHp+XYZ/3hIbtowUrEBphSGrovLFbHD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783131146; c=relaxed/simple;
	bh=WtFu/7isZ4dlFs1BNOl7NircysrhnIaG8lu25+BYPoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEtsPSEEcP+xQFrC1f75ihYPT8RaOgxB7kBZO13Hl6dYysf2m8SjtIA/hLHM5ACp5bZcnyszpPtnAnjudHTl/VKMiia/tF51JYX6smdknyvnwPnMTN8WziACu5NmeAc0CSM4Cg0m5GRFbfI2tKkAAbydv5S7ABQM4KfpZLZrEiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElX9bTPi; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElX9bTPi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so760456a12.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 19:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783131144; cv=none;
        d=google.com; s=arc-20260327;
        b=e8Jz9rreX3QtvCjar1QFuJQnVAs8rj47ZGx+PK1gQAGcqoltHjpiylLUKMF9qwbYte
         hGMWjYtNht5GTGx8Quic/mq4vzaWDpCIDyvTDnPUtEecpUoxLXvWtEOyGqVMjL+zQrTO
         tjfa8R9TDhYjduVhxDZcl6+bAZaAlN9VAnlW4TSFHzrxhFVcEu+0PpiMPraEvygm5C8f
         WqMEbUp2D6SR6053luAERCRH99r0ccw5ey/fiH1/9jAMYeEbHKvUruihxz7BGZook/4Y
         WmoMIj2/F0o2ggwBjJwbFTOZXEr2j5E1x2xMpxyODr5nFL19tXFUZo3vvUFm13DVSe6x
         VcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qTEF+jxKV5MhhsYoWwK9gY1uoGZyNE3Vd1jsBxP2q4U=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=RnSujWHksdQh8PCarmckVhCFduk4dH97zqu4FWzjfM4kGDPRda6KfX+sILlhBQrych
         K3NHO9g0u+zKL7ZjR0E+/C4TZX2UE95HR/4yGpJ3kgQWdD7XBnK6BhGguzXvko57JBIa
         yAs4betIIO6jHkhOZG71+SBYRq+oVlbgWPmT3MeuKwDid4WybN0xAdTDtd0D4VKyVPS6
         i4NV6qNj6PIU6y28Yvt6oH7BOqHGYJx6oOAGrWFLMZAcSDOzGd/OcS0aMBCUW/NWGYua
         SQofUkM9FVHh5NRsE6pQjt6lpUGRQhELD8NPfrCHi4kACOli/S7SRvchiKxqBybiOn12
         UkXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783131144; x=1783735944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTEF+jxKV5MhhsYoWwK9gY1uoGZyNE3Vd1jsBxP2q4U=;
        b=ElX9bTPijXL8HUUu++LxXryjCo1r5ag7V6fvI9Wmgmz74wsEqYNM7Xg2xGkveZI/BD
         fsjOmZ0h7UlNjZ1lLLaoTdXJzpfpLKLpCHJN0BmEDLmtF5b1YCEm0X+zBtjOFRxoZxtI
         ckVZ1Cagzyv4h1ah9GoxSeljI32yKcIqqxCgNvRWw+iLZ8NmeYOx8tMLoaSVTQnlqia/
         BqMuVVpiLE7pDKvr0K4DwiRijAYvrrfJUuQzESibBcMNZGvsw4YxGR5MtV4Av2apSYPe
         yXgOCyhhF/QYirgzB3ebtruJT/UJeEjN8+GXvnj8Q6laCBRoQbV8C+YiP7lCA3E88x9I
         aVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783131144; x=1783735944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTEF+jxKV5MhhsYoWwK9gY1uoGZyNE3Vd1jsBxP2q4U=;
        b=GPqWqMUOfHsBC5tCJ1vnlSh+h6yxdr8uozFqsjD4h+/Y7X1ENGJzyvAWYaFHzOzX9Q
         IY4fwqsFKeB2NNGIuKuwmdwPgyUMLkGrPVdfOtCjASn48ouglzesfwygeHZO9R4ozMpo
         MavFI6bV4tdXchF5o3ZYz650bzYX7xLyZcmu3sphxoIv47ydvrJ2RtCLqm4SwOGYly46
         GqDFFy8NJUrU2A2ysIJ3m6x+At2ODpm3wWli5YGc0BmdqG5qGGCqi7OYb5X2ghH/gmP+
         p2o3KkkS8Gp4hLvHLMima5UJlJY2VjmfmeYStvqe/1wvq5grghOIZX0s9cZql0p0F0MN
         w3Cg==
X-Gm-Message-State: AOJu0YzCR0kTj+031/V7m4xCQaC/A0hjAS1++Us2QtzipQz0EgDGM7Jd
	26f//dmxgGyqedKxB8j60HbL3m3IYRe6U5ixFxpm1otGJdGot+MB08P5S8ol6dLigG7aVGXNdxe
	5mYdWRUAzX+s9o+9cypjm9p0goIL3b2trv1M4+3hpmQ==
X-Gm-Gg: AfdE7cm8snvb30Bb/yFCB9M8MZkn33VHmTv0I0PhLpESgjRdvDG6Q1UeRbQjl/ab38b
	q2vFS0ColpgAfHoLq8ayyr9Gebf3YO9P+3MqpF9lKcbqp0S8qLbmJOkPQ4EAP/jTQ0t5Vpgg+iP
	SD1Ogw4pbQRa++vo5OSGsJRCzJ/IJAhPa0N1+EksvnlqvJRQZiXJ1lSAr7XYpx4YndRd5nP911c
	RjX8sPLJAn2zwjofCcA6jZ4tg5IBsSUZ5KV2K0f6BEucS++qhlahvbqWuA7t53We8exiWtIlA==
X-Received: by 2002:a05:6a21:6a0d:b0:3b7:d9d6:9fc9 with SMTP id
 adf61e73a8af0-3c03e18bb27mr1523827637.2.1783131144242; Fri, 03 Jul 2026
 19:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com> <2026062933-storeroom-amusement-0b66@gregkh>
In-Reply-To: <2026062933-storeroom-amusement-0b66@gregkh>
From: maher azz <maherazz04@gmail.com>
Date: Sat, 4 Jul 2026 03:12:12 +0100
X-Gm-Features: AVVi8CcEcw0s9HAXZ2couWs6WgaDEK3NnV2KxkcK-KT-2qNjLaUUzpSlL-MEyBw
Message-ID: <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you Greg, I already sent an email requesting a CVE for this
specific LPE vulnerability one week ago.

Best,
Maher

On Mon, Jun 29, 2026 at 5:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 28, 2026 at 08:31:35PM +0100, maher azz wrote:
> > Hello,
> >
> > Is there a CVE assigned to this issue already? Thank you for patching i=
t.
>
> <formletter>
>
> Please see:
>         https://www.kernel.org/doc/html/latest/process/cve.html
> for how kernel CVEs are assigned.
>
> </formletter>
