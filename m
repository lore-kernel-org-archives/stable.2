Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933566;
	b=krHjhqe1i8R+Uu/AoV/LVufZGAR2bFbYJ9Lm+o2YCyrxUNpyGYJrs1sgjWOJHAqu+hxO
	 DdKnOvmYAStNjfsAC9hhJdoYgV+4O2+xDlr23ZKjOTnIvvifEMDq3LTB7sCfFFiajZKAS
	 SZ6lhSs0q75mTxMTcirx36vHBlDPfd8OIX19vLLamvRlDxLktFV2LqiGTtC3D1k19tNzD
	 sAeca5C+mX5kjL/sSeeoVqRKFUWcp7uiHsOgkz0MLUe2MQeaPl+YVv/C4+PjG2rmv5RQD
	 JvYHavoIGIGmc/r8XbUhn1yLTxEWmZ3U2PQXWjXeLT2g8t8FRdV4xRABbx3xQ/pamjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
	b=TYopFxLVnlYjq5WWD+rX35IojL4MlmZSi/8Yge4IlMjdTkBVtNlVv8MADmeLYvm6EFRm
	 rZrRG/5Oqkgoyq7YsLPpPwP9qIAdUdp4ujE1FyPBK+NSf3DKifLQ3K46e2ymzwmDDrw+Y
	 790DCCMDlNYI6pwtG6jf6R6I2tXPRzSklnLskvpxYOfoOwgQ147QT4o4pEBYFL+Qd2K7T
	 kbzGuc4OrAAmbKddHDd2icLY/3KcDtZ2WPujVr+9vGRGQxRF6bryV9mgB9ElmCWTiTDSE
	 LiYbl0WC5/1ZmLTVlWB2WFxgXvCbpnXIuXhUMfr1WebEL+QG/JwZ0ZbIgN5CcJ9rZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fTE72B86;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC512606A888
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC512606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fTE72B86
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so4369696f8f.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794933562; x=1795538362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
        b=fTE72B86Z5rEBpDKAc4NHne/GnXGff3y7H6Jsc0ARGDiGlXWQffN+vDa57pln4ARyL
         +1G26BfEIl+HbVOj8TA3zSW1iNP9Exo768h3A9fSHxf1A+G4JzKjyZmNEbRVK3OkKcg2
         ZEYnzKWCZf2SHWcITYJs9lOAqrrzZPxMt6krNLkAMsJlTuduP0x2y7nYx9OSgn5tmOQc
         3GQldmEymfObWSixuhNM6I5Mvd8VHZwvi+nOGLSVWlk5ZzEm+E3HJN1gWAo3zwQFeuvx
         9iNDKhUwBHSxIZWVigOWMhavG6aeEqqoqaTE87khyMl0FdFXi08urXs13qAdOls/ZlVA
         Zdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933562; x=1795538362;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
        b=ofvOJIVZ6P92U6XGDiHUYAlS51PjtOxLeRjCoZMB8ib/G0URh03tuFSY/c2GZDPNLC
         VKvUxCJMljfHHgRKQIPWSyxuFWf5pem8ViZ2wMx/WqfXDq7P9VF54OxvsZeyivH2s1Hj
         7W1VjofITCShtnR1G5v1VNmOJu0gJEqmIrTGpKg0tVvd5lBgDExqoLyMDORmroTaYTZD
         /KkYxw3hrvbMAXL+r5UNlNgp5cP8rGkhRjJwknGcmtyEeEKXnYKeJchVJ+KeSLiuDgc8
         kmtao+z+DX9i+LCv8Qfs7/Tnz/IjEM35H9P2ZaPfEtB9MbTaP6glnpUmToDwWfrzwo0E
         0kHg==
X-Forwarded-Encrypted: i=1; AL+hErF3/QEBPaydz5niWaPv4Wj2W8YxiPJjPI3M5fTBWnzmHYIIE7Y5w5ZEmr5TVQ4xBn7FG7b4KPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Duhdm5a9xUBZOq3A1dqst2+tcFCpxcgVzBh2zWEIJA1ehhOYK
	+qO42in4XY6GGOMUT15Bp2ZWAWcBBG97Du/5J3A/z622ky+ZgHit2UafZB4jSkJhqQs9
X-Gm-Gg: AZFdTZeEBJBCcVSRouIE0O/6pJbxGT3S5uKKKM3gdH9Y9UNN8u9+D3Gih+ld2Wol/89
	gHGj9ZT1DV8K0hIUId8b9TrTi20jbH659FdKRBlwyr4jwWo/h1YJGujL4s51H4lYDOJuR/MvdNC
	OLAAsY6c+73NOFCAefuwj339YTFVOWzH2hSq107m7ptnuRN9ZeuWqmCUfCsCVWp5Xh2DoqEwQMb
	ttEN0m3H0T7/xRcMyGe3r4iqlZCzwSsYkb3chkQkdnGUOSJCVr8n0cGZURt2zOSimRRw9eLjFx5
	q95iZePjnYLmLBh95LRDHtDUpMZnhZ0FSmusvapiSge0QqiPyF2ddNKpXZCaOxLtQhgjJB15xf4
	UKPiHnlzt6i6YfgFpT89DTSygCAIRsbRVLJSg46yWrdaUe1BqGY88sxFedQYd3u27DOR8qZf5r5
	1TV2JkggOjEJOOEK7RKFxiEJW+iGOg9WS07dzwfXZz930fh3zLa3q4Qky0rOCDuAUfEQKRWGCmk
	ATTXZ04VXOxxlIdEV5Rn7dORB0JQdetWrXRbOrmlKAzQNlsFWYEn0JCbdn/Fr568yUMjKWAQeku
	tauNxsODhpoJ+s/G09mRyLp1wkiixy7rN6agozUCUVktpTp9Xc/gLj09lqb3iOj5dC0RngZqPNa
	FTC4+MJp640rHbeAfFbFNH3/YwgeHmhVoK4JUh9GgyBwSwhtsbaBGw5hc
X-Received: by 2002:a05:6000:15d7:b0:48e:e98:8b6a with SMTP id ffacd0b85a97d-4a6332bcccfmr19985f8f.4.1794933562080;
        Tue, 17 Nov 2026 08:39:22 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b? (p200300cf572c2800dd2ac8cf5d96bf5b.dip0.t-ipconnect.de. [2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a43d41ec38sm4564311f8f.19.2026.11.17.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:39:21 -0800 (PST)
Message-ID: <a0f9a7e10bee8b5d328de14e1bbdbf74f5712d43.camel@amutable.com>
Subject: Re: [PATCH net 1/2] net: don't leak pidfds through a short
 SO_PEERPIDFD optlen
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,  Sashiko
 <sashiko-bot@kernel.org>
Date: Tue, 17 Nov 2026 17:39:20 +0100
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
References: 
	<20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
	 <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 16:25 +0100, Christian Brauner wrote:
> sk_getsockopt_peerpidfd() caps the caller's optlen at sizeof(int) but
> never checks that it is at least that large. sk_getsockopt() only
> rejects a negative optlen. So with an optlen of 0 to 3 we still
> allocate a pidfd via pidfd_prepare(), copy zero to three bytes of the
> fd number to userspace, write the short optlen back and then
> fd_install() the pidfd anyway.
>=20
> getsockopt() reports success but the caller only got part of the fd
> number or none of it at all. It has no sane way to find out which fd
> it
> has to close and the pidfd stays in its file descriptor table until
> the
> process exits. Calling it in a loop fills up the table.
>=20
> scm_pidfd_recv() deals with the same problem for SCM_PIDFD. Since
> put_cmsg() doesn't fail on truncation it checks the size of the
> control
> buffer itself and sets MSG_CTRUNC before it allocates a pidfd.
>=20
> There's no point in handing out part of a file descriptor number. So
> fail with EINVAL if optlen is smaller than sizeof(int) before we
> prepare a pidfd. Since commit e10899b2a098 ("net: add
> SO_PEERPIDFD_THREAD to get a thread-specific pidfd") SO_PEERPIDFD and
> SO_PEERPIDFD_THREAD share the helper and the latter inherited the
> bug,
> so this fixes both.
>=20
> Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-205984@kernel.org

Ugh, I wonder how I didn't notice this before... :(

Thanks, Christian!

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0net/core/sock.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index ad414878dc5ba..74a00a5e2d116 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1746,8 +1746,10 @@ static int sk_getsockopt_peerpidfd(struct sock
> *sk, enum pid_type type,
> =C2=A0	struct pid *peer_pid;
> =C2=A0	int pidfd;
> =C2=A0
> -	if (len > sizeof(pidfd))
> -		len =3D sizeof(pidfd);
> +	/* Userspace can't close a pidfd whose number it didn't get.
> */
> +	if (len < sizeof(pidfd))
> +		return -EINVAL;
> +	len =3D sizeof(pidfd);
> =C2=A0
> =C2=A0	spin_lock(&sk->sk_peer_lock);
> =C2=A0	peer_pid =3D get_pid(sk->sk_peer_pid[type]);
