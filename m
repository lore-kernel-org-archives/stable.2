Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457924DD17
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681479; cv=pass; b=hEXfmUAhdMcyyofmOZyFHFtSrB/0L2ZINi9er+T8bWJ+w1O8Vtlo3gjS5EA9r+tY1nVdYJN3I+dpZI5hv8IPpCRgml7/XvRTNv9ESdfe975F2UWiyUOsaaBgr5FG//fSwyvfHRv/JcvAlWRRgI4Q4jBvwJ8hv3QSVXJUcqMPTWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681479; c=relaxed/simple;
	bh=fnuiAUzH8i1RXzJbjDNXAl12hhVXicwYx/CWz3s49ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCyGcycTLryhzQR0GhKDlBHMwIlMnQrew3Xij8nckei+Ghs7f5JYnj0Pxi2UITulGAtd/bdD4j5oQGRLfGcPFRzU4GZOEgf+jt6T582qkC/sTZPV9IVrjWAngjwfDgx59TIBvuLaStIR4fgNi9RBixJlCbouWApgvzj5GXDsBW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=m/O6ffgE; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="m/O6ffgE"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67583c777abso734313d50.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 18:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791681477; cv=none;
        d=google.com; s=arc-20260327;
        b=Op+0P12IiGqCgfM+Pz4ZEIXVJttj5OYN4jTZa+h2QgAtjROZxak54o2iF3B+bziAPW
         3+850augAlclTc+RZ6Idh0WBbyk9/DNqXjcBv3xOg5VNkWh2NwWMzjl1YsqYyis9DaIB
         /qtmDD1NEUJDdUOse5cuiM9rF0pThS0LdisbnhowZHs16S1kaDitslrT7hLpgcuTCEQj
         XfC8emWqLcGYUmWBHFAFCOwRSVULo5NuMOoXhUoL6GeKbeUeJsodmFy9ezWT7aIqWx+X
         JhlCPwLiwUQhGOWs61Ie/OJX4XDY4IuhTyA0P2kOxkKOcnpLfJB+O64HDZFi3ZL6H28y
         qjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bzVBreIIkdPuKDnn/qisn7+R+ttNV+LZ3ilnD4kWs40=;
        fh=e7ggA/XE3PM0jnbsK1PyHaZymhGI04QauLNqJmdOFn4=;
        b=Tv0FEsIGrfeNDOncDMbaYbzSrBYNndoTdV6w72UlQgoKniKgvOlW00Pf2/gBKdRbOJ
         fUf+p89RlZfnyZYwF1WGVMmuF69dRN1W93yrakuIDIULglommiNbCFBeYkfObdbKr587
         gbCqnpOp1bycgSTSzUeaGC6znR79SGkpwWvvFpuwShsn310VBz5HzRWdNIHo65ceUHxX
         ztedad2EAWIVN85OVVUcjlbScXTSiBwrLoQm98VLFueiMYsQl1ATg2K00t7+zhMU1E15
         1+JVUG48UEYjVyzG0+jkNFKK/5OQ1S8WOJYh9zbhbmbHY0omaGoXciuYs7AEOj6AxYJb
         JXcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1791681477; x=1792286277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bzVBreIIkdPuKDnn/qisn7+R+ttNV+LZ3ilnD4kWs40=;
        b=m/O6ffgEwlymbGYeEO0z0/7tbBmFlMxQI2JdomPUPSui+Tx7Qv4LcrbyUMk/jw3XNX
         z7+PHfREREt9cFtkcO6xI2hd49eAE0wmCQ+AqxdzC5hymwq0XIgqQU1zgcLDUlU/k06d
         o7Tra68cReB9SqZwRS1kQrK34G8xrxL+VOyLlHawi5VxLlDqNamy9hXWKKBz7+UeXIFD
         oKX+lvCd6fxBgAM3JwBNbPHdAipGJBA8YFq1AmN6xC0X1wZyFFJmmctLnagPJquOoP2n
         if2qUQxLQQ8bW+HrZO0EoxkdoVS+QN4hcIckVeCOGw5PnHsOOUwfSGUzlxShtB3bCxGj
         Sg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791681477; x=1792286277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzVBreIIkdPuKDnn/qisn7+R+ttNV+LZ3ilnD4kWs40=;
        b=OuLRNDnEnTxT3NWjPSNaE6aJ9XibDedwc9ctph8y/R16adfWXRONKeBVw4NT4wIP+L
         F0fi75HEZSm2/VVWEpY+A4hwSm9dHyOOiB6DFuUh+xT/WAQ2JgZ0HDme+fjSMGROVQYu
         KDvWt1ko2/MiEh1nJ1jFUrgatGPVUVsPgZlUGVLEO1mR10n5enTTya7T0dxsZlpFKUS3
         Ow5PTdIpK+oQCsyRfNh0Gubroi9kTLi43tNF42PYK93JQy868tg27rgsXEtinVpqHe7J
         3MnxAiYHnnLL7+POda6n27rerCni+SxSlcxnSPrCHu6wio9Btp0zZbE8lQYfI84de19T
         XEvg==
X-Gm-Message-State: AFq9FYKUpwI1MKBBLx/oUfz7mDaKtG0IPAggBNeWNGRmEuF0jcKAeUMe
	yzenVcltX7uLUyXxA67V+jhVUDln4cGwlLjbLJUJB5qowHZYQJdVzzDjVG69utfufhqAsvs2m1n
	QJr/OpnsmMKNmGyXcLdPyhlt/8wxQL446wtgmZgM02SbQY4X2MkMyNMQnwZZll/BxRmNJto52yg
	JSW+Qc+8YvJKoEMXrH+OVW+iPI4NQc0rGWcnx2yHkoGIU0uw==
X-Gm-Gg: AYBFou0DEJTaQbL8prcSbp1QtQYvQoJNL8QZa7SG29qDiR1cqsNreBnFBE29mq2PSVD
	J9/MJzWwk0z7vH5OhGkvdMv1+ezVTHXRqcfXK12drpNWNRJVmPq81HytZx4AZVafb6a7otUI1B1
	Yn6dXL86Fvv3iiXhrrp/HmWC0SOOyiHB1fSzFMsMblxBWfJufyJd+JFBmlo6Eca8b+t9WFMUG/P
	Kc+RIdu00T3g26lYYMw7KAV/MCTqQSTXAYGGgEr4Anr0YbNlzM+z693eG5615Nb3I5YK+XRtP4x
	gqAVNDvlx75Wk4r33SKsURL85IpG2PAVdWPJkT+AVXLSB2A7Ei4dlbztcBmRykQwGrwbE+5VWlL
	2X//y9x3wDg==
X-Received: by 2002:a05:690e:190e:b0:677:d35f:c4d1 with SMTP id
 956f58d0204a3-679369f7abemr1942202d50.55.1791681477199; Sat, 10 Oct 2026
 18:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140952.119038291@linuxfoundation.org>
In-Reply-To: <20261009140952.119038291@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Sat, 10 Oct 2026 21:17:46 -0400
X-Gm-Features: AclHuK-o_Bx3fweFB3qoGz-32K9Zbv921ZKMnF-L8na-GXc5lR3Y1ZGIdt8C0w4
Message-ID: <CAMC4fzL3rK3pdiZLpnVv_gju0dSUYp24AWnk1VTHHvch1xmVBg@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/403] 6.18.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rogueport-AntispamServ: glowwhale.rogueportmedia.com
X-Rogueport-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Fri, Oct 9, 2026 at 10:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.56 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Oct 2026 14:08:27 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.18.56-rc1 built and run on my aarch64 test system. No errors or regressio=
ns.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Cheers,
Slade
