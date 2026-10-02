Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56C3749F7
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944534; cv=pass; b=QfBq1gcCKw8yYrhHGJ77dWidq7C5ymvVnFPtHv6MsYZbo107NsjGhypSmU8oL3wpADTGyo8iXTOK1gig4iQ4u2cqsB1bNwpcIInYsJu/njGXZ7IlCkabL/vysuPE4/qkdt4a4aBw+dEYU9lZFeSxfdFjP3i0nrBo3IkPp5kG7+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944534; c=relaxed/simple;
	bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFPb5+Yl9nsHkXsldoceCw7KzyVL76F5OgvL0jZiLaFXGE3SlZt5rY228i6j/RM+tAFHUsXYO8pFs2FiPeZ7YfHV3Of4jPhkfUF9tXn93MTGaagG4wJPgDJFnVAuFdLGgW58u2GOckSPzz60nXVgBuURJReZj0s8nHlPCbAW17A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/NEsgJL; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/NEsgJL"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so11033143a12.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 05:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790944531; cv=none;
        d=google.com; s=arc-20260327;
        b=PEZmcDqTxXg4i/jlTsQBDGlHubwbjsmcBPX62wV/D3nlOEXviE43J3xdwBigMvKNTR
         KMt75drKafG0E5/W4a7s3iuwmiB3hq6IyemLgKloyx2eTxZk+xwdSMzAffTdVmdeNZlI
         6xvQkRmyL5T9HAJNnnmzRc0t2H1lX+L65B6MQn6MfQqY1600pmQfB9zXAv9ihHAYH4ko
         yoC5XAoV9xoowxAI7DRj/WWcmJNyrvfaAzHlGN38FHK1xbXcd+D8RkxOy5xz0c8blAqd
         7CjIyI+Z4tJFLpdFOGDS6UxjB/81N8EibsF++6RRdb5gmplMxsVu6NCHp+6rlbkfRLE/
         LKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        fh=CAvDOzg+XcWC5LpM+DugKgt14LYBrgVKQF0CsS3uLV0=;
        b=KDkUT/PmX7nUwj+8e1tKatgTVuvaLLg31LHJxmtrsmWrGPLfzhv4FQ7fY4LxkYuXmZ
         Sw5fwct14APYicCmTF4Z4Rc1VNhcBT8vHyTTwbLKZiNxpD2o/oxRgSKth94pQZQDQ6DF
         irW51K2beILJaEn03siPri2oHfI1E8gYH/caimt93askvL2X1dkfAfO/8CW9xsZ7o/Hn
         UPEaeiggldgss8okrswSjCUbK+NTtkGAeOcQ1l0x9LRLpgelTvIGiH1v0uNG1qr/pJRv
         Ev31FMTe0o8Z4r7kJvczuHtBSBT5du2yXFf1xSs3mMV+obu+QHh2DGRcBLfc8WWo+Diu
         K6Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944531; x=1791549331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        b=B/NEsgJLmQsJc4ZodJrgL5R8Pi+rrM8G4dXnN1gEqnakWp0Da44FRip5Pu9QYTz887
         oMBJ+Y9y+Ec5WRQdmBhwMhX2cuQsiRHpfraPcYKjqPF0dkqVRacbNg8nnBElkd1fiQfQ
         zhSCR+wo/1oEy5oErl+aEFFNFx6N99QMKtXxd+amrRmgRBwmp06cV1nIRARDmv+xCw4/
         olmA42Ml6GlAR/aGdbwwElMVO5igcRyaz5fk0Ww46SDEtMou8JHHQgkm2bobhCXIt+YC
         OWX0I68TDaoawIdIXijKXGg1RnzjN0Sko8arHVzaLuFJD2zVzz/jppyToMQVIuzNR7y1
         Tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944531; x=1791549331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        b=SDFRItc6zmNbpAiIs77eJt1q7LIDDDcELLytvvGbP2bxTaTj2lB1O8nem2YsMqIL4Z
         zAH1upxSGzTD7ld83+Qt5cKyIVtWyzpINz+FDHRC3e1X97pU7gtnfRn5EKUvAJrWGcTX
         bEQQmEra9/xEtiQkwQmMS17+OH2y8NUnTP9WkB8k6p13BNzh62NU5yybj8AdLnuIa/pm
         nSrTwGKngyzx9GF9Nm2nu7wMmqK9BBR7okIke97pJsNOm6VU9NLKFNAJWIiEAvULcNZi
         4yQ12ra32m7WhrZ2ZjbsRgQr2xfjnzmltz4u8oxWTVjXzCFAxosSA2MqfhuKkK1L5uSM
         Gyww==
X-Forwarded-Encrypted: i=1; AKwUvBypg9lOPiQZi0dChXBUqqaza+DfoD3BRC+b8laM4bmeIL9gspMmG8FbtTDDaFWeB+zGJ2h9qlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lHkQR6go13/RjgNUF0Byc3fluRlm6A7JWYyHEc4H0GY6hXk6H+
	96WLcxX1fzawzAf6gzHEIM+c1FmufveuL5MrY+JfuPTaasSLwrI+xnMMHWGJVUhPeh6kcpn2q07
	/tcO1JtRXkfoRSCFq8Tnbe23fH1Sj3jA=
X-Gm-Gg: AYBFou0e6cPk1CNkUBzUNGDA7VGCYlQzan46zBlhShtiYsSozWMKkEzYY4fRc8G7ZUp
	dm9BmDwBzUQ0gOmrqjX50F74AMOfedYA1OXitSyeGaio1NKEbPVqpkhsdB43P0IlTYVON5G5tg/
	bqIfDmY6p7Bf02ctsajoLUPXA9LE5r3hrtDWupTfLt+rGm2uq2xlXRsSAFpL6SriqrlSsT8Y6pv
	Kzon5xnVU3RBh6YMGXwQ3k9Ca23Jkxyt5sJvks9ffHTShv/EyyIIkVAyPjRxWk4KmuJoptgY//5
	0vsgooyIfPRQ02m1kYKeHP7bABi+OSykHLybrI0ni+lDAnUjxJ2P2w==
X-Received: by 2002:a17:907:9490:b0:c29:f5d5:5a96 with SMTP id
 a640c23a62f3a-c2e4b20d9c2mr208899366b.32.1790944530536; Fri, 02 Oct 2026
 05:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002100935.449473-1-al.kochet@gmail.com>
In-Reply-To: <20261002100935.449473-1-al.kochet@gmail.com>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Fri, 2 Oct 2026 15:35:19 +0300
X-Gm-Features: AclHuK8oT17fr99ppSn_bGvjxkd_dqcCHCFbqpWJG6tCtlizdpUY_p2i8jO-OAQ
Message-ID: <CAKNVLfZG0cnu09mZ2HYRRvbSd4uLeOBXR--nUHK9YtOb+a0TTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Input: matrix_keypad - force switch rows to input mode"
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 13:09, Alex=
ander Kochetkov <al.kochet@gmail.com>:
> Siarhei, Paul: you both agreed to the revert in the thread above, please
> reply with your Acked-by/Tested-by if you would like it recorded.

Acked-by: Siarhei Volkau <lis8215@gmail.com>

Best regards,
Siarhei
