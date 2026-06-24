Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D827587D
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267787; cv=pass; b=jdaGZZyI1AeYDqFZENjxdQL14BhmuevxtqxXYbt4dQ+e/hJl11UbAWaDkIlKOL1b1BOCndgKi5IyemDdTfqfECr6Db8yT2HUzGbasUm0iGMWzcMco4n+ZVb4KmOMsDG3HfWYxQwyoensmmtAbcFmohFaejZSE/COhBZRR4S/Jwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267787; c=relaxed/simple;
	bh=jsac6rbK4xMauh48LXVsFpmG/TamCoh2jALMIzpP6z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+ZJo2dXhH5WDggMuWPVM+UHRrupOe2CiEmXCZriLjujx6bQRkY+l0/U668WLqF/nrJGazM2IS/WWwZHmbHROxO/S/pL7QvDEWXsLljzZhCn198/HWIszUxeMFPQZne26UxPfqRPGbL1nkLMzC55OSToFxtud6O1+BZA/z+tVAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxFNwmee; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxFNwmee"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8e066990fb4so6454976d6.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782267786; cv=none;
        d=google.com; s=arc-20240605;
        b=CqzjPyeYwo2LJRnV9HJQAw36smKPZxSwoDOQZl/+ul8aHKlX0O74Gb37J7ty2Z3JYw
         4m/g41pg9IbTPuUC3V/hLW/p6/jlTY1aalWgaS0+qPgfJNdReVGO49GCYF+64enb3QMU
         K66NwB1xMNF0SHUSjbEwbJk8fTOCeK2h0xjzXtNC+/3f6vw8WzudfnXMiEMGr7aTVb5k
         f9OowDkJmlvRj1vq6i649jp7plug5kM0fmwPAZUvRC6LEPudI8J8t/+238glRDjKimdr
         AoyF5zWNsQsbduGe5Wz64SpwW80UnziplyVe7N+eGl0kg2z9ivbhHAah814ahcN3H6Sg
         5XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UG0ncpJL7hCVBEGIAE8tEHhgRG/Yb5WAzpKilo1RSVI=;
        fh=iIvLK4UQ3j+3E783nJobSeSRcz0REzSlnL1qjuvT63Q=;
        b=KQYwY1I6g1ErpsgXqPnSGV0ARtN0XV8AeM5ZWuNGX7IS3peD9NZiP2zSzxZ/zqI+Ko
         tMA13achBEunMdxC5c6wlYD36xDm3W6MEefbDI1MjQo9Vtyz/jjOHaxhof0Q40BS6Q+Z
         6hZDnqs9tU+tmCwDZdJDP+6ZEwvM8W1bEufWzjv1HxL/x1BS/aggh6CJFSo195o1bnuu
         PLht/hjZf05r7ksLC3C2imglP+kMESB2zfRQygXcJJW8OTz3SNyn8xCY8GNhrA1PollB
         acHp9Qr43t0XwMbIJn09TUyA8zLQPzVJWKk/5vhy+kmn1b7wLP4asVOlWhZAuYXIXgkg
         jR5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782267786; x=1782872586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG0ncpJL7hCVBEGIAE8tEHhgRG/Yb5WAzpKilo1RSVI=;
        b=HxFNwmeeLELoJKEcwaB14XD2BST1mMymKhSV69GCNC6NJcAHGHMads2g3i948fzDQZ
         I1oQFRLCvEoPg5gDhMfVtkTOcMa71uW33eWmW2xvy2t0hDnnbMAqlEmtL5BVsaZDNx/C
         eeR1AD8C0b78yE3M6XQ3AHBjFy3jGi6vlTbxJ3nKy3UojYhmcXFTC2t2K4CwgPzuSLQ9
         aCS9FH8r5pM35SLCxrw2NH8weEF9a8t+ZD9vuWvUc+EyFsAo/LkzFbUZagXntlHLX0pQ
         1FCNDm1AqRlqr672QrMa7j2Jb1UAkMTToMpnaO7T6MjS16o46uPBH/EdWMdO3A9nUWyE
         v/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782267786; x=1782872586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UG0ncpJL7hCVBEGIAE8tEHhgRG/Yb5WAzpKilo1RSVI=;
        b=n9E4e3+GVxEVCMi6pvWng+Cd1k+knsESaHCXOlLtHMiaYV1fhT/ntb+4oKyyIASe0i
         pgzQQe7oMQQGBTh356rBJHJn/1RhUlDKLm11XAZbtFwphWra2ddF58jH0/Q3JhGL0TzQ
         xpQHYkWcMvuYcx83EIHeuUG2JZtyjanHYjTwUDux5VOB1DlJ2DICFyEk5Vwqcrz4mpRA
         OMZyNvRDG2j+8KI6ZHWEBmb2W5CzODkR/OleXHDaNRrCDuRn5yk/G5QrMWbfFNwsj1SJ
         YZLTfFGnmIiP3wz3UdkIwNpjRrjS2ta9EyAM3npSgKKBZ3XpdWDfHSaQ+dNUJbvvfyx2
         p8Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpES7KLbSwFf9gLct5nOf32D6FamhKT4FBpgqy9hFTJq2CsccXyS1+1PLojt46vl66lUGtp/v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+o3me2X8Wjrufqd2L4LokHQzbalA51tGc4jccfE7w3W7VRZ/C
	C3zadPl5L4IiQinO19YAdVfFfLFWTxDuNiL6OWEwlEBX7kYEhclprkm64IODvYJYf4kYKrOAvsW
	7ap6vkCt1ApiJPn2WZ2AUyvZrDxrVV24=
X-Gm-Gg: AfdE7cmChOUQxI+F2haTwOWiXYMrNcUgpVx0nCymyfzwL1ENlLM5/AT/+4JYfP9yZpa
	6tPf+T0gSINLlvQE/FGwa30ZiSbfzuBFRZERWC3N7smLWh4CpkSGuvf+Mqh358xBheVHShAVm8C
	c7uWLcGMnSfvNqruRMYwC4TTFs/eUaVDgCuM+uiE83Pzu+ohCEJJv6ENB3u95RjzYrC01NtjSK8
	fFlv37Jz0MkrhmYxy6JF+VafsQwxSIj4j1/vo1Y8mAVaVw8rlYrtxGIV0mtqDAkt39Z1uT3iYJ6
	s6P4ok8buuvE5t/CE0q8BwW1Q1Db6vEp6+/iuQC+qWzAq2cF1AVOpGLg7N6PnxsbDiAi7/Zzx84
	datj/8jjRZ3GhY7oamS6dxYGc5uSmvOnL+Gqbs2XXijgmgbPyZy8JJL581YsR5IumXVIoJ5MkVP
	7+gpRx0Yh3vog=
X-Received: by 2002:ad4:5ccb:0:b0:8dd:8c77:69e3 with SMTP id
 6a1803df08f44-8e400732233mr102978116d6.9.1782267785732; Tue, 23 Jun 2026
 19:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623014538.1705722-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623014538.1705722-1-haoxiang_li2024@163.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Jun 2026 21:22:54 -0500
X-Gm-Features: AVVi8CcwBwpsQHfJ27hjWZbAayGga5WgChQB-ZmOBEjyw5fU0tfa3tIkMrpJFM8
Message-ID: <CAH2r5msb9j_iX5OBz1OdR38StoSsmSECtBkrMsFchff4OqDSxg@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Fix next buffer leak in receive_encrypted_standard()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	pshilov@microsoft.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged into cifs-2.6.git for-next pending additional reviews

On Mon, Jun 22, 2026 at 8:49=E2=80=AFPM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> receive_encrypted_standard() allocates next_buffer before checking
> whether the number of compound PDUs already reached MAX_COMPOUND. If
> the limit check fails, the function returns immediately and the newly
> allocated next_buffer is not assigned to server->smallbuf/server->bigbuf,
> making it leaked.
>
> Move the MAX_COMPOUND check before allocating next_buffer.
>
> Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle c=
ompounded responses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  fs/smb/client/smb2ops.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index a8f8feeeccb5..c39944dd40bb 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -5111,6 +5111,12 @@ receive_encrypted_standard(struct TCP_Server_Info =
*server,
>  one_more:
>         shdr =3D (struct smb2_hdr *)buf;
>         next_cmd =3D le32_to_cpu(shdr->NextCommand);
> +
> +       if (*num_mids >=3D MAX_COMPOUND) {
> +               cifs_server_dbg(VFS, "too many PDUs in compound\n");
> +               return -1;
> +       }
> +
>         if (next_cmd) {
>                 if (WARN_ON_ONCE(next_cmd > pdu_length))
>                         return -1;
> @@ -5134,10 +5140,6 @@ receive_encrypted_standard(struct TCP_Server_Info =
*server,
>                 mid_entry->resp_buf_size =3D server->pdu_size;
>         }
>
> -       if (*num_mids >=3D MAX_COMPOUND) {
> -               cifs_server_dbg(VFS, "too many PDUs in compound\n");
> -               return -1;
> -       }
>         bufs[*num_mids] =3D buf;
>         mids[(*num_mids)++] =3D mid_entry;
>
> --
> 2.25.1
>
>


--=20
Thanks,

Steve
