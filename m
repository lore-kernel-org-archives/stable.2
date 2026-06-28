Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE329994B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666129; cv=none; b=VOEnQF8RczFSwmYqGsJSGRZrPZq/f0IVNtZ2+Bl7/VtBFjq0GJrRPMBI7gU5OCkIX6D2PAMavBOdXuz5IraV0XFdCbdAqy7DLStvbRSeeOYcaPW+ml/qALK0HV4Ef+Z2qekuyxaZ5Fk+/9M3oi99iV7Ibbt+RB5rJbM+E7cXq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666129; c=relaxed/simple;
	bh=3OsNKGn84AmZ7EpZHONA4D/sDqC0/NfOYHvlRuLYVb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3SUYBCKeAYGldQg9XcFgDGaxmYqv+NVnbRMcK2a18P+pTdHLBqU9kqU68f4xOC4K/KmpzJY/xv85cmUZjx15XlHT9o97zY/g3xaCUJgERq5/dkFUQkoSJIF39ZsZXhX6FSgHT5fgYDXPrlf5G2ahmXgJ+1quytLyqKd78Ly10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEOUIvb/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEOUIvb/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso33271215e9.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782666127; x=1783270927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVQvFBwvnO1RdffMStECk4dJQSfRULIl6EHx460540M=;
        b=pEOUIvb/4MIZkIuL+pC95YgEKqOE62Ma0vBd6s+iBvLfa4aFcauDFP3TOK8NtSvGUZ
         BsbIp2vR3PdopNLUsJLT/zMjgai8EU709ZC0npyt2918w53PA7OBXsPZKo5KjtiOoLbs
         zJrcloJG42z+LzTu1ns6hXqIcI+o9dSrwujg2oyeOMl263JyOwnnAJ6eAJz+xvxTBMgq
         iyLq6Cw4Ao76/hK9xS/Av8cNk+2yXcjfwo9fnQ5pjL5h4CSwH4GUIGPt6BcPIJTRr/o2
         K8T7FU9Z6+4xhLBFB59bLLzSmXxJ4pSWCrDYX6j0i40+4aSnqtZjxR6+5R/xQATe7UR7
         v2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782666127; x=1783270927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVQvFBwvnO1RdffMStECk4dJQSfRULIl6EHx460540M=;
        b=MYSSGQY23wpHHvYLcyBz1DxlGkYJQCAspC2EeDWQ4pNaZZ49Wf5lSphcPDTNemkmgo
         uiOp59AvW3slpBi3RS9qF+i71hJRbw3/JgZtr+X4V/gbmQi1nkRhsEFAzv+2cgNFEcNt
         FKowIyZWcelHG0k9ookhlPFqF1y2QpWRYJLWKfkWnAJEHkjicW3rYIw569aHpxJqL0DO
         pNZmwiLGxtsxEHxdgZZo34IR13FDrVkCUYn5XjbhL5RtGrAO/1BJKWspbGTRVaKOnwWk
         9JJ6wS4IGX/9BeCYFVpPIIr0ob7D9Ak+wASp0ENakHXC/73U4wmWpQVdLW6FSC4OAOMt
         LR2A==
X-Forwarded-Encrypted: i=1; AFNElJ9Q49Eq7cmussHdLcbtctiJ0LHAUqQDnOkQb55xfsVYg7B9ox3af0A6eyLPhEcBbuCOccgeAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgQOrzAE2OhIKJzDILkVB5Y9I4DTrGV4/euzcRShiAjnVEyby
	WdDSfvVwx52l1olhzh7qnw4oFC8IdToAyKXxXb950U2T1fMZsPh7syYSCAFE5Q==
X-Gm-Gg: AfdE7ckJ2b/dBSHymWOyYerYKltqIUkp01rNOy9xWvW9G4tSz/b4QirgJHHLam15KSy
	7x5Rmw5ntipYDWEq74M18kH7ByDsYIrgrHPdRKYTgT802jaKLMWxdb4eGaiRUPzX/PUKJDktmIy
	e8k/ZwatgKMwWOdCfOfuO3hcMu7iFzWskAm4wcvhtQF/w/EG22lmJKuUQNjOvVcfWt3Tq05/viQ
	chE0bctZhizvR+iQKN0kUPK87551bQnAFfIUoUcFPt62M9j4VoL3OPa9N2NxXCNn3aW9w/EcYF4
	Dstk6Tb14SJJp/r13hftLM1k/v2kF36mjlrcgoGP2LBPNkzT2QogPTliIUvvyvKo0HCunD4fNUe
	36mnx4+rpN56hKMMraO8K4j2E96fMgSmeIwcJP7e/K2sWqezuKEQqX0Qj2t+VWz/dcTPZgHsFlY
	1NV7JshA5u/Q0T96DJG+367EtF
X-Received: by 2002:a05:600c:c16f:b0:493:a7fd:15d6 with SMTP id 5b1f17b1804b1-493a7fd1852mr32215115e9.9.1782666126285;
        Sun, 28 Jun 2026 10:02:06 -0700 (PDT)
Received: from foxbook (bgu190.neoplus.adsl.tpnet.pl. [83.28.84.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c2954efsm160059395e9.2.2026.06.28.10.02.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jun 2026 10:02:05 -0700 (PDT)
Date: Sun, 28 Jun 2026 19:02:01 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <20260628190201.00afdccf.michal.pecio@gmail.com>
In-Reply-To: <62e1fab3-1045-41f3-bc74-4c7624011619@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
	<567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
	<CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
	<5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
	<CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
	<eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
	<CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
	<02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
	<20260628165040.76fd608d.michal.pecio@gmail.com>
	<62e1fab3-1045-41f3-bc74-4c7624011619@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 11:48:36 -0400, Alan Stern wrote:
> > How about "keep unrelated changes out of a stable patch", i.e. always
> > do the delay (if any) after the first request, regardless of size?  
> 
> This is not an unrelated change.  Rather, it's deciding on how to behave 
> in an entirely new control pathway -- the one where the 255-byte quirk 
> flag is set.  The old pathway is completely unaffected.
> 
> I suspect no devices will have both this quirk flag and the DELAY_INIT 
> flag set, which means the location of any delays in the new pathway 
> won't matter at all since they will never be used.

If no devices will have both quirks then new delay added before the
first configuration request will never execute.

If such devices will exist, then it probably won't matter whether the
delay comes after or before the first request. Purpose isn't known,
but it appears to be rate limiting configuration descriptor requests
or delaying other requests after this function returns.

Either way, no known need exists to add another delay before the first
request or alter the existing delay (or its conditions) in any way.

In general, I always object to code which serves no purpose because
such code is easy to add but very hard to remove when it gets in the
way. There are no known users, no test cases, only paranoia.

So I would keep the delay code completely unchaged.

And skip other random changes like error string nitpicking. Reliable
and up to date information about how many bytes are requested,
"expected" (what does it even mean, to somebody reading dmesg?),
received or verified to exist can be gained from source and usbmon.

A stable patch is supposedly supposed to be 100 lines with context ;)

Regards,
Michal
