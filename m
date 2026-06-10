Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF593B27F1
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126114; cv=pass; b=P2GrnBpPLMAifUTLXTax0BUPv5LYVkKXfWJH0RECLyGsCOHVwHLn4n2+5YnDLwSb1C94q1+K3CCDxjGDqZa3GBWrdtmO6de3g7M4BA104sci2o2g6RruzmiVxaTS2JOzPZS0lAg/1RfwFySjNVXvCL7gq6IKEphf7iZXYCDhCc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126114; c=relaxed/simple;
	bh=EGpQzpJjEGw4p/nsDBsR+Z3CTFBHxeyJAhSw1nUgaVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDj/BRxlPi1b57n/QqB40CYOMJYhBJHf0WaKZ/NqFrS3wa7V6iqRKHBkbGbKWgU3BG9Ul5qOAwC6SgYaf2cZZYXg4x1PB876ewRyxTAJZScCr8b26AGQfx9Xv8Y1EEFS4hWjoG8HHTMDfSBzdd0G+iUbDQipN/BW9sFwmB7yWDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMj2x0GM; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMj2x0GM"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9df31130so108224546d6.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 14:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781126112; cv=none;
        d=google.com; s=arc-20240605;
        b=Qx86FfG9JqjBP95MOuzAhN717R8FT5TORenB13FhsgqTnDUnJKbxHWkDkuoz4Fs86h
         xyGWbUB9TWEvqTD6j1J8CaRGPL1BAbyEHA+YzxBYDn1hEoHHfHTSMXev9ID9IPBqLAFq
         KqzaAQrGP7y8vaxTxmRz3OLA4PjnM7u/M0DBQXv+r1/Dl+JzPcdbmIIdaKRgyZWnRCiM
         LTqFasIre6HMfz92sv9E4kPYAzbzmwh7wpYjG46s9f9Zheql83bkqKgtjq9qZTJvlrtr
         nP8Wz/q0HM9kMX86c6IwQLgPbRUqMMSgQze3KoFk0w2H5HLx7pnwOheD1zcgSM7Jf+YD
         ihvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CnEP+eDU+Z47vl3ZUVZxc4v1rI2pyGOwLoRS96m3ZO8=;
        fh=HynRpUN7r70BVxqsHktzdBFoNs0sTCkeKjGENVjUp64=;
        b=RuZArRZeMESLDGzUdXM+btqfMPmJj7jXN18mLHY6L1yaZ/r9W3CiwIJpDtzEc+Y2Wn
         oIfspYjccr0rA08ysGud8xlBKzDpXNFyCL4YbmSp27SO+8ImdADxEf5wHooYQRt9zleb
         VmpGcRAzEcMwZCOC9u5RrXdTfUHaAlv5xAn5JCPjsHwOEJK+D9azIga1N9YaDht/isLy
         LGJEx4oCH8NM8WXm1dzFralmNwz3NwL9p7WDbIyurPHOFwjo7sAfVbYCiVkFA5bCn7W7
         sz5+/U3DR6k/7M+brlc6qk52GrNnsakh6tRLlZt9G6u3pqVNs/nYDrLx2bDAQbSkhwU8
         88Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781126112; x=1781730912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnEP+eDU+Z47vl3ZUVZxc4v1rI2pyGOwLoRS96m3ZO8=;
        b=iMj2x0GMpjqB04Le1FF9HrUcGJY5ah+5BxzqP48I4vHqAC603ZqHnX/ZFcarSvusbv
         wlDQwmz/ZAG5uWPZmOsLe/s3LVz2YJ7/QlX9HfMHQKedo5TsoVZrRi3fUnjFNyVlDEE6
         FhxLwVxP78Y5Cn3tMKpBnG7Jr/VrdaKsXlgkrMtMisMJPrMw85nFvSis37rIleP+IHOS
         43xArgMH+8ImhnST6/+d05+Cl13NrE9JaOWsCOlPEfkC2To+UYW6RPvDIT18EFywN2aQ
         BubS/r3+Rit2qCpqVYkO51xFPyQfWqZBbhKG/irlQ+dUcnrhftcYqVLqKfaqyLz2x9Aq
         piIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126112; x=1781730912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnEP+eDU+Z47vl3ZUVZxc4v1rI2pyGOwLoRS96m3ZO8=;
        b=K+q5Ce0GCQbJ3NZWEdwXiICm6x7pK8Rguv8MvxsHLGz8CItTt55o83kN17hZFfYBnH
         JLuWUi/ke/woIZGn3Ws0gzoJvtmOg9p6babcWsxJdNq4C6mePGx/e26oSgeXzULIoJYt
         9qn89HlhvgkfGSm63n6DyZebB75q1reKeEtqHKAyxg50yObSLaToL0eLsR/RCUySRb+o
         Lu8q0yCXV1jX54MsOYdbvaEhO4eETOOe3ASpsbOKuzwbVrhv0nyyjIz20ApHZnFhQz++
         KPrmv1HikbAYP1ubRUf+VYdvaeyEPYssSWSjaWhAtVwQHc0VOf4VdNEtCk88E91tKjiR
         GYgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SqVndF/awkTshxcre5LZlAqxNUlf0o0LWBn37UQittnIUoUVnp4fFfkDcdKAPeIGbmYeK3fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9TUZaMl5mVadGe0vP/+RhLQUD2jw6/Ajo/ce7y7iQxA7j0jb
	1PE+01uDcWLs6Pdoz3AhIDTyv6enJvQWxUhkh1rK60iwT8U99Nc+aiOLX3y7HVQ/PgEwnMlzvia
	HjO7GZWRMqaTGOmw28/TK4DiybdTYXWU=
X-Gm-Gg: Acq92OHg+joCAZHopTOmH67wsEoK5FWyJ3LgOJMuNWDE7oYYybOzIupdPpsiU4MxLnd
	ddGy+F586vmJMNWwMFAC4K13rVYsrO6TX6xEiGruhqybSxLDy7pQ9kcfBU0SQdaZ+USZMtfeSTz
	eADu93Rkm+SEvfWFAbXNKTX3cVVtZMcD4yUJNoLZd9OO06RlvnS38Mq5FhqEBjM1Kg7EYDM/VlK
	cB2/OMS1jociYVMj2yOnvxfSmEjtMXDexFzqPwRjc8wHPQ7nPisV7R7dRHWcmvmvdQFpCQTtPrn
	wkKkNRInRTasuJ0wxdQZ54cr7lIHTQJbu8cAWv1kYXvUaO0+yx0=
X-Received: by 2002:a05:6214:2f93:b0:8be:3da0:bba3 with SMTP id
 6a1803df08f44-8cee625bb2amr449999006d6.34.1781126112468; Wed, 10 Jun 2026
 14:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610114120.3748526-1-michael.bommarito@gmail.com>
 <CABPRKS_HbtV5vWx5nHT9rwJV4TGmOPj670yUuLK-Hd-r6TBF1g@mail.gmail.com> <CAJJ9bXxMvSfzttjiRATN1vkVP9-RyyH-P6O4yMwVJGcpZVOCFg@mail.gmail.com>
In-Reply-To: <CAJJ9bXxMvSfzttjiRATN1vkVP9-RyyH-P6O4yMwVJGcpZVOCFg@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 10 Jun 2026 14:13:24 -0700
X-Gm-Features: AVVi8Cf-VVmXHd4G4dVcNeo3e5QSfEMnGy5UCy4Mcsge7c2VQHC5_vNz6ydOU3E
Message-ID: <CABPRKS8FJMHSsitLA6CmS=jyJYur9tKd-pG5mLxrbj9B2aQj5A@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: bound RPL ACC payload size to the response structure
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Paul Ely <paul.ely@broadcom.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

We work with operating system vendors and notify them of specific
patches to cherry pick into their distributions.  It will be through
this typical method that our partnered vendors will be explicitly
notified on how to address the reported issue.

During the next lpfc version update, I will CC the stable tree on the
planned patch and the stable maintainers are free to backport at their
discretion.

Regards,
Justin
