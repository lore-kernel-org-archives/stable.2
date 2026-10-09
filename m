Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010922D7A9
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508357; cv=pass; b=JVUN7zBYVGkJaLulnzkXxtoU5O/9egn3dCw5VVuyNmaf/zCB+TQNBQLSJiQF3ePczTE/aaTqW6GGQy5EiQcjxD+7txHCeNxVyitIEJTm1UjmTTh8IEAVkP/fsqsdIgK4190LvkBQ+QgkttdOVXLtXnrF2ZKBj1SAH1I+JRimxTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508357; c=relaxed/simple;
	bh=2bXMDwVEYUSw/XMXG+524Ph7e3RM6JayBzXlJizXsCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZhmZ3Q63m27FluLcfsEPL0FYTZS2bUv5fGiBGLafLUt0IFXVK4XrCtpWCkAbEhSU4y59cCmn/eP9GyYOcfUdRitWdxAX5DcX77qSl+eZ/P+UbRZbcEwbTAcGFtrAX5XJ1HoVEul6GWAL1pPwJDEf8V4SE1lbTPeC0EiFi9w9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR4OtYHV; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR4OtYHV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-88834d30002so1891005b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 18:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791508356; cv=none;
        d=google.com; s=arc-20260327;
        b=OBLnsCvj/C8/ckfweeRZhoyaQxaQB1CErn7m6WEkEbB46pTo7lm8oiyi3lcwGLNesk
         63L7Nzf1r16XA9lgDIE9Qm1fyMjLcTEEKt4MxVaYBtPw3XOIaTjNvrVu92ou29Sj3bLt
         HVOGawT7yXcjF/ft3+P391q0aKY1xDI4YQweyES0QmGYbmwbcNzxLZzFPePgapSOIeCT
         Dhm9lHS1HbWYAmglILiv+N27uhnsd+GfCI78sqVTZc3VAYBp7K8HMNn70EJhbYkNxKqO
         gCg+VAxKdmw7AIbEGcDvoCB+vaNq+tLJZEzripFilPfJvUP0n2H+TmdjV8zIefm0jay2
         uM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        fh=2bV8RSvQilSFfJMoeh15oNmZJhLiqtziZciBWkpHRfc=;
        b=Ww1VQqg1WkfVvY2OAHWrHropmRN6ZoE6a4X4DALdYt/g7SocNiqKfN6B9UX0kr1BJ2
         AiZ6htaWfzJt+OtfQPQJ4U3lncZcxuUa9eDmpJ6crVcqZBpsQY+0iuQGkIwtDhz5URvC
         ifuQaMORYLWa0IhrQjFoinr/a7+rc88ftU/cEoYsH0EqaR0s0tTds3gK7lRfUy1DwlB2
         KY/qmtgDLtW7sjwVxT3EJAlc1BLuOBoBQqw22/8rTW2McSB94pfApANVThULomSTFn59
         kTDOfjMYFBjZ9DANwEEoDUIb4Cej53aT3nDTtMKUDtWo9l7u8aLe2xYAkOBMzI0vxXsI
         Wmsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791508356; x=1792113156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        b=cR4OtYHVgcibPwmHiavkY/FAB5ENYmg/QDtUb/1IryRfPVgKg+ubFht40ut4t7WU1A
         oMqT9r3HYcVBB85yVxtVOy+JF8zVQbSQCJ/oNyWKav6AaAAZGp5yD4DAyMHMk7yLWJ6B
         Fyao3AgC7Q6btwdwe0WMjciuc6YHmwdpZ8Bnq94uRN/Ny5lpCCSv8RzNaY+ZjbdK7Qxi
         NwnCnTgc5Hn6lD+hqrlMr7btrpWuR8KYiaUOVKiUIZJ65r23Liw+/d9CqtFIgkyp5gwR
         nJO4tV132WxG9IpaKgxRj/rokle9+w8AYRVYyAcNHy32PbwSiux8B4Bc58QYCHsnC5Gt
         wzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508356; x=1792113156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        b=Jhe4T32o35Lk06Nzxy/UasDcc9rvnvWENbp1PyKSTtlc7RpyZot8M7dpNOwFkPFK99
         KgpBbf3GmzNvcSsKNjQTxpAf9GuK9cFfCBMozG/keVM3aSHd3pzAgOQ8MQ1kTMwaLyvn
         gTpJujrZbTazpVyzGMvj+Z9HmWaCo5sNLn5aejXp5Wi6QJcBI2sl2lEKVvjKphpw1qze
         X5X5SGYT3i1PO/9c6azEPaYogC8eg/vwuopcahfpjt+L0+umT/6npkCFOrU6K4TDBpac
         7WXFKNJe4wMryjoC0o8T9vZQB7psXUpK66XqI/gskLHjxgHTnxeuBzWcrZIKyoPGvITk
         jCTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzmTuPaOXqCP3SxOnTCUfy96YnjOf3rWrYpjUL0d3fFEK3f7rq8lv6aV3fc11e50VM5mZm/eQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUixyRnU/TZQiWqny/SiZdjaObMfzzNL2WLDMeL+bG1to4jKbU
	Qyt4F9OIVFlPcBlN03ogS1I3JC3O9s/h3Q8MIOe74MNx+sYA9BSjH4A2zFI3h3jQPb2uTSiPWIg
	8fweSvPffQibryJAp33zTO6H4DTJEktk=
X-Gm-Gg: AYBFou2zs3KU35GXTeIeKe9dBQj8QeRDf9zdPprXzeOXVR0V4IvmcwSmSkbxBIQu0R2
	UeSZjYF2AKwvieaBxeOINGn/1pfjrB2pdYOKnDfL6ojHGOFjuQb6/TorvzGe8kTevOHfpECxKhj
	dvmgVsigLKIKVe3bUBviuvNkXPAfUudiz5gTGHySvfQnwNuSMqAcauaFq0mArYeMG24TJAnPLLq
	saTXhJFlMXS9Hdl7uDkofWq2AFdM3uDbSCID3TwKyMTPSnKqiV0+vO96QHLC1BSc4WdGp5jwh70
	eI0HUnDQmcq3FUEtFv2uYgVvVqp5eh8tLM/N5H0RWi+/2VnsL7BX8EQjSnkAMqOc11duq8rXRc5
	1RB6COGOfyOYQH20YqF/PbqF9rqFxFSobX8TONwKryEZEdmdNLeHe
X-Received: by 2002:a05:6a00:178f:b0:88b:72d6:b80e with SMTP id
 d2e1a72fcca58-897c5d55bc4mr259823b3a.13.1791508355601; Thu, 08 Oct 2026
 18:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007035739.3472432-1-4ncienth@gmail.com>
In-Reply-To: <20261007035739.3472432-1-4ncienth@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Oct 2026 21:12:23 -0400
X-Gm-Features: AclHuK_m_kMGuBUY_F3PNA9Ts1xvaJcfDaoJFu7BhbCtEygkfb1YNmNxMxISybs
Message-ID: <CADvbK_fEWi7XFJgU-7Zo_pQ-a2AiQoJZHs-jhspYQ7xgNCKNyg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: revalidate output stream after association
 connect wait
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 11:57=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> When message interleaving is enabled, the first send waits for associatio=
n
> establishment before building its data chunks.  The wait drops the socket
> lock, and handshake processing can reduce the output stream count to the
> peer-advertised inbound stream count.  sctp_stream_init() then frees the
> extension of every removed stream.
>
> The sender resumes with the stream that it checked before the wait.  If t=
he
> peer removed that stream, sctp_outq_tail() later dereferences its NULL
> extension.  Fatal-oops policies then panic the host.
>
> KASAN: null-ptr-deref in range [0x38-0x3f]
> RIP: sctp_outq_tail+0x49e/0xaa0
> Call Trace:
>  sctp_primitive_SEND
>  sctp_sendmsg_to_asoc
>  sctp_sendmsg
>
> A range check alone is insufficient.  Stream reconfiguration can grow the
> output count again while the lock is released without recreating extensio=
ns
> freed by the earlier shrink.  The stream can then be in range while its
> extension remains NULL.  The send-buffer wait has the same issue.
>
> Factor the range and extension checks into a helper and repeat both after
> each send-path wait that drops the socket lock.  Once the lock is
> reacquired, the validation remains stable through data creation and
> queueing.
>
> If validation fails after the connect wait, the auto-created association =
is
> already established.  Return ESRCH so the existing caller path keeps it
> under state-machine ownership instead of freeing it directly, which would
> leave protocol, counter and socket state inconsistent.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
