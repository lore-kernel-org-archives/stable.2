Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5338398D
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062267; cv=pass; b=XunwXisSHaoQez8Fv60jFa7dtzGxeSPnkPx8aBkc8G+mV87yUxeNltDyTRTj9GBGRHrNhuveHTLzx4nsElwNeGXsGpvLk28JEpEkpGccJkymH4ox0VHrGsgfpfkWIAdI7yIBllz8h0c44totyJ3FzrOcWK7/4PFKp6Hdx1l+KQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062267; c=relaxed/simple;
	bh=+WWG55iPmetupBVpWvPzN8FNXJL/33pLOLWrSC+icwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQnefwVPQsAHTE8BYGJkI7Ww4tCMIk7z0qzwNhSo4pKXbCEIBEgk+MtsLSqcBNKGCUBCcERUGnNyOUPF8INMtahI4iThtLJtZeEsF5AuNi4qMo+Z9Bpq0TWbOypsjowjmnhYnt1AMZNht86IPf7kwfNGDp6I51D5RNcvQuYdVXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EDhjp3KB; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EDhjp3KB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c12620ed112so27986066b.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783062264; cv=none;
        d=google.com; s=arc-20260327;
        b=My9dBLmNiLdd0FEoORF9N6qA6kVlRCyBWfZjjOLBG3cY5JL1DXfxHqDgZvP1DWquT8
         Yk+Fj/3du0Zg0umZ1xoSzSV0yhIuXywShKVeFSwqvypP67y7Lr/wlzXVY5aulh4UEhRa
         akhAm4IRiYZ+Xq9LLV03gP4MFvED4DpX3E7IUD5HMaIgKGcB0sKYTkuXE0ICrat8uGDL
         nQCk9E+PJiypgkcmnKfLojTBxNSQNHnatvqsdL9ITQbwL+nKubfW6ZIIE5ekn7WrpRQc
         v0zNS3smf0Sl9H3odg+/9qd4vUaW40E9oisQZaOHceWx7xaJgHjQmVuTOCvgiMOf3orc
         qxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MOh02fA3SZA2iuzmQFctiZnBgRTP/PzpfIgUWp1N9lY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=UipzY10kqQcZm97hCK9PFcV/TSivNOUFsrBn6Tyzg1bTB6x5y/QDUidAfwLrFf4I3k
         IPgjXTZ4zbz++85kZWJQ95pRbvi6UogBocZnppLGBjAjDQgoyJoVNFA9LVec88RMGNr+
         6yQPdGIU6fvQnlRPcEg5OuP+EkJw0Z112ZfVG3xVrDTX1W223Lipb5iqVkqiO+SlW7Nc
         o+qLBypAEkiCYSr7zLpEBSI1WsAUNClPI7mbhVi0c2lia74ZzGB0asoKmI050lrBk8w9
         ea+m0s7TA3NB8sUGOrXOFDJnBP6zMj/Hf66TTkaTyddIxYzHnhnu6MX7jJchgsHZjNX/
         SzfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062264; x=1783667064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOh02fA3SZA2iuzmQFctiZnBgRTP/PzpfIgUWp1N9lY=;
        b=EDhjp3KB1QP+EktWrZgjoAlKrsBQbk5VeLe5rsz3sDCelpH7tvfNC9LtbTIOMYvqkY
         vKULoM+T5YoVysSj3PauFKk7slQ7NIbW+pMG9l0QReS72o6Ojd7umGq83H2Ocplz8CnE
         E/SpT6Sp9E7vIiJvPFuDKmtFfgW+W18YCfRpo+hmsMoc8UEY0rEkA9XYbYpBwpMPLxu/
         AKYqQ5OHzVt623D2iNuqxVM0rdUCBRtD8AoJXkluFF5yysaTQgK45pFDjcr9DC3xdWgx
         WDNLV/rJVccVy2b97HiioNoOYFfrpz9GUpdXdTLAPC7Ko+dchLtKZvaD8qiXZGRQwudW
         qisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062264; x=1783667064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOh02fA3SZA2iuzmQFctiZnBgRTP/PzpfIgUWp1N9lY=;
        b=LSTHVLVsF0Iuep82p12W75pRk6Qw7Ay1BE5R+4NQJXAN9SiNvMLTbrwxxPCF1r5MjD
         DSjISxkNM/Dz4a6e43K5IP3QEwbPAGMTPlrroqtVl/zvRZmza/GqH8CqJRRjCDLng/2c
         L24yJTcQIgLUDHY/ysUDAGd+sFO7jZSwtj+HzDIqQN6BOZfu6oZpjW+GZNMtkXhHNrn/
         UHPzIqWfOufNRZ8Vb/SCOsWwA78U7qBVuqtDXXgk3q8xNtsg+ZciWRknMRCt6Hgc6aII
         MOkCs9QK/U5hDRxLaGIGdIJHanQeFoe0GQBxLzg8B2DiAdrl0fwBW0OuhAtxazAlFXBD
         NpBA==
X-Gm-Message-State: AOJu0YyGyhzN843T4GoVPKLNgJCtoiYIPRb4cw1g5qmzuPz+dipJJlfo
	ZeB8Kz5m0qMPXo2oSLnqtLQUZYHtQd4xFZDjmRgwb/6Mommeox8hV7xcmIAjxqoQaOSRf3qQ43O
	T1zOYWBra5qCelMBHbhwo4FOGH6F52o3LWoGUXc7dlQ==
X-Gm-Gg: AfdE7cn3tllu5jDe3YW53bIDlRTPIYjMuWwLtD3f3r6p4G4hcHgOy9MO+DpnL5VqjEl
	y0EGz6DFpwNN2TATK0zxCprnV9hD1Jd15uRu1/htHbfW2sYnFZaXXYsvqONoSjz9UnABywtwHUm
	Gg9K8IqBIwu0jzQF6wcx7q3XJOpLl2Tt7hfv52mZD0yeTg9LX4Bw8Lf/nB38virCxPV6Bp7/8RD
	q7yzDCZr2tAxfQRi/mM5Dw/8a/Q37u/GERuCi4y7qecVsshedRq9sbKVia65VhYQVDyhtk=
X-Received: by 2002:a17:907:a0d6:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-c12a9d6c21dmr367228766b.17.1783062264082; Fri, 03 Jul 2026
 00:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625125645.554579168@linuxfoundation.org> <akddu8pDgJ3itnfh@u94a>
In-Reply-To: <akddu8pDgJ3itnfh@u94a>
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 3 Jul 2026 15:04:13 +0800
X-Gm-Features: AVVi8Cd0csi63uxIrDTRJwEkzLcN7b-swi0CfEO28G_24PsvVFwDgkCXK5KP-lE
Message-ID: <CAJFoxQO=gH5kuXdzjYmTwkvB_DcqgTjn3OU7EcB8UkQtnX-Smg@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 3:00=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Thu, Jun 25, 2026 at 02:02:45PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.18.37 release.
> > There are 60 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> > Anything received after that time might be too late.
>
> test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifi=
er
> in BPF selftests all passes[1] on both x86_64 and aarch64.

Oops, meant to reply against the 6.18.38-rc1 review. Sorry for the noise.
