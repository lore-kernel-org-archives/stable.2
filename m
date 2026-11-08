Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794097238;
	b=dcAH7KxX0LDcMqAbEd0u6M+Xd78z1LkKrinXoS0/y+QlZJ0y8dh3a8Tq801efO86/THJ
	 s/8d1v+YI6AyOVF4neKAdVZ5WXsQnHbMP4mD0Qnp/QnjxHj5KtpyUAW1PdjOjRMGDOO0K
	 bOwLTE3KeAH3rkU1bbkwd7MKOxrmyzmeUbHiyO84vfvy8JLOm7v7bREwlywm6xBfutZRY
	 os0JZJGTCh+ETBZggZD+ZWu08xfzBFxqkbO8dHrEDju+zhnqMDmg+GYjHPt0M6QwjgL63
	 LXRg1aL4PR+J/xAYyo/jvrm8jY+4IFEFgF5S69K3d/AehizCIeSfU6KM6OwFuzw5Nag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=LfTmA/OXs1u6qLuWZSk6TQ3M8alcSeTvA25XnpvO6To=;
	b=0ZQzYbv0ReyIVzOdn6Xsgh1lEx5QM0pmq2rBXMFTc1jtJrvLFin4qAcxl7uNfLlqbduy
	 U5a1XlJy8YpFrHEVWV8Jb181i5Trbx9ZH2ymsZUeTVWMpCpheCfMN3jTIrUStXrewV4Wf
	 Xy7G024YtqbURJizccPt6o+NeJ5L2XpKB5fOQBwBcR1pI7gqLsStdN3qNHAGvJTOeDab/
	 Yn6Z1+VSvZOR0yQRnEpOenPEDACy1THRoWImViBZnNwVaH3BItC9gGxZrWnZAEfoDjdFO
	 UmCmp9FJ0+jl+xiJMWl/ChddJjy7LPjYSWNo0RiHdTUxpIYJmcqXasuu8/bL1VQmBLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cv3XyfF1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5203606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5203606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cv3XyfF1
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so86770a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 16:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794097236; cv=none;
        d=google.com; s=arc-20260327;
        b=m05PtVcUJa3MqBQhQSSnxo9Qf75FLcSqpyeMxb6Bp9Euiqn0Ewa+/RVbPkGTkIesqa
         q0ocWbfDKXkxBYqSibQQyELDtdtUif4LjNcfbSZkQ5PW2TL/O7OxqOhE/ld16kKTyF6T
         RK2+3KFmwnF5nJtYdso7uHCD0phguCz7H3IU7RnHNcXQfY29Xz6MCNnfWVldIT/3poOr
         xn89kCl+c9DFm5BQ9WixkBxnP7JQuEgBkCPBQNnHfa7rR3GDccvKLIMWKFWdWKzFziX0
         VN7jjpzUb4PPwKQC0MMKSzDOH3RO8miZ4Vv5/PRCEkGek6r4E+R9FDZIQ/9zfrg62C3n
         7d3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=LfTmA/OXs1u6qLuWZSk6TQ3M8alcSeTvA25XnpvO6To=;
        fh=8PMvphGrrJHPO70po75/nO8UIDsijEyGk/2SPYAuYJM=;
        b=Zz6TKPAA4oNJYbf3X6zwkEpsJXuAgS/lefy02oBHmJauJ1lDU5TYDdi26bSoNL9lt0
         N72UE4IaqRH7VrEtHjMp5VMq0FShLzGC5UiV9EsxV/V/GROenlLr5/RsRybt05rt7xHo
         TLRLLzkhlGoHRjdY6D9ugEcMjI8x7inEkssrKG325jSylNwAsqhjsPKLWoE1TC2UMFks
         2Bx0Hnz9p7nRRkbo2u/8vBNjME0Aqs+e7vxWbbsrl5143npy1EQIAlw1OhSe8A2JYr02
         ZD3v4ZMMyElO6pUbWgGwy4//gRGjI3VgbuXkR+NgmhIKWgz9VcVBCT9dsarXaXlwmBj6
         IbNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794097236; x=1794702036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfTmA/OXs1u6qLuWZSk6TQ3M8alcSeTvA25XnpvO6To=;
        b=Cv3XyfF1qxq/FA1/EGe2RcOV0lLMwcD16foodQ2cuGva9pY6YsYpMFzikiLqJBmUwK
         3eoyXVCrQuNcePrSYYKveLO7wEyrXna8RFkafM7vsE2anw3BXr8Z1sSvk+FdcJuTOOfz
         jFL4FBUkTedaRQ2EYP+OY1jBq0fSTDf1D3X6LkjHNtJ497qII6EeHw8G2EkHHhcNNQbH
         IUUwcvLdQXhv9+SGDMFKG+HjOvd4zPqc4L3pstM32u+DIOYwCvSd6nWkiVL/UCVLDW5K
         lLgM7Q/sQ7QIojeKoPL5mvMg3Y9i+r2kDfQeqvSLH+chSVGL2VTYsutegaoUo/+JLYDO
         kRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794097236; x=1794702036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LfTmA/OXs1u6qLuWZSk6TQ3M8alcSeTvA25XnpvO6To=;
        b=etIhsrjGzGPyV7hPlMUcA2dLi9W1RAxzys77jcdFqhE6yKBle60mkYC/2nDzJn4QMY
         ljSfcu9l02ZUKQ6+m7ESxnh/PwG7er3NAGprgbaAZyFQSaAga1UGa6MjSiNzvA5mq9hv
         28LkPqzzDtMuuimj56zbHO+RsdyU68I+tmhT0gkVy+CpxdFjYwWRxgt4S86ZexOOntMU
         MN2D+vSlgkc3WqsI6JbRlRq3SS+S33AOwCpkBkWzhuTz7ZsJ+qsEctB34HPx76vNIdLD
         SUumM5j2vugQt+gaT5n3KlLlQMSCtH9/kzo3RelG9oAc5wHRFYQLckhRdDOdj954wGU3
         91mg==
X-Gm-Message-State: APuU4Z/T38T31WYLukRl7btYAN6rbMl5s7auNqrxuKl3ZMe8Ija/Okbg
	imxtKHCqMarsNyBxYWSJpcwu1dB7kpuUnRXXe2IJtd0YT2cyz31e9smyLvb9Vy6PqhwNqbyOp4z
	s7yLQaoK2sxtKVjEKtmEsf9WdEtf+WX/wJcJ5qcYyWw==
X-Gm-Gg: AYBFou0LFaHzX//oj9UzX9xP4i8MZQVdu+ZzvjU0x0zHXvgyPmlCnUj6vg+u7sOdzAl
	3l6QSduY+5newsi6orIxOA1HmkxiKXa9p+w1iJ+g0BHD6CCWndx2ffZqHBJtuAzkM/jhtVl8iYa
	husD449QJ2U2gt37XvdiWN6CpPcLA/UDeugx7nPKsuoNasyrM909ypXutc9Mh2J9rrziB9VZMms
	vYhAUVU7x13j8i5vRrKacWDcwxCXH+l3GVdulEMOcIGCKGmwDn4Y9AyEaWX+YDPwVj4QwxzWBS9
	7hCuc55Xmt5vNdzWCDr2bQQPu/UtgXh1rYSKshO0FinK70I1gKikpsY7q4Fb1g1b1OZTINka1zJ
	z56j0eYvCJ+tP0tRBVu+sz0jq4fz7lG2w1x621pJHx3nd6kcOUwCoJQTBKKXYSMvPeQ9jElVRua
	jNW5w5vaGXzdpoX2LoYg==
X-Received: by 2002:a05:6402:13cc:b0:6b7:1cd4:87d6 with SMTP id
 4fb4d7f45d1cf-6b72240d407mr137434a12.13.1794097235599; Sat, 07 Nov 2026
 16:20:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammed omran <sanhokh30@gmail.com>
Date: Sun, 8 Nov 2026 03:20:23 +0300
X-Gm-Features: AclHuK-kjxVXRdM9S9zuf9Sqoftbt75oLZt0TxuQV_WPGwwpUhGB04UbylM3jRQ
Message-ID: <CAGwSD7R7MPL6ANw71gAh4U7YpWhfRZQyaDrSibxfvy5CnZ-SiQ@mail.gmail.com>
Subject: [PATCH request for v5.15.y] ksmbd tree connection UAF fix missing
 (CVE-2026-89788, CVSS 9.8)
To: stable@vger.kernel.org
Cc: linkinjeon@kernel.org, cenzhang@linux.microsoft.com, 
	stfrench@microsoft.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

the ksmbd tree-connection use-after-free fix landed upstream in
September 2026 and was backported to 6.1.191, 6.6.160, 6.12.114, 7.2.6
and 7.3, but did not reach 5.15.y (5.15.225, the latest release):

  b5ec6c462aab (7.3)        ksmbd: fix tree connection use-after-free
                            in smb2_tree_connect() (CVE-2026-89788)
  63f5939b5047 (6.1.191)
  ca3a3984bf44 (6.6.160)
  bd58a52738f7 (6.12.114)
  4e30fbd26e84 (7.2.6)

Evidence:

- The CVE-2026-89788 affected/not-affected table lists the issue as
  introduced into 5.15 with commit dd45db4d9bbc ("ksmbd: fix race
  condition between tree conn lookup and disconnect", backport of
  33b235a6e6eb, first present in 5.15.145) and fixed on every later
  branch, but the 5.15 row has no fix commit bound. Versions before
  5.15.145 are not affected.

- linux-5.15.y's history for fs/ksmbd/mgmt/tree_connect.c shows no
  commit after 2026-02-06, so the September fix never crossed. The
  same check for fs/ksmbd/smb2pdu.c (latest 25 commits through
  2026-10-30; the branch is actively maintained) shows no tree
  connection UAF fix either.

- The vulnerable shape is present verbatim in 5.15.y's copy of
  fs/ksmbd/mgmt/tree_connect.c: ksmbd_tree_conn_connect() sets
  atomic_set(&tree_conn->refcount, 1) -- the single reference --
  then xa_store()s it into sess->tree_conns with no tree_conns_lock
  held, and returns it, leaving the subsequently published
  tree_conn with only the xarray owning reference while
  smb2_tree_connect() keeps initializing it and building the
  response. A concurrent session logoff drops that only reference
  and frees the object.

- The lookup side of the same lock discipline was hardened in place
  when the vulnerable shape was introduced: dd45db4d9bbc itself added
  sess->tree_conns_lock and the atomic_inc_not_zero() guard in
  ksmbd_tree_conn_lookup() (both present in 5.15.225 today), leaving
  ksmbd_tree_conn_connect() publishing with only the single xarray
  reference. A follow-up concurrency fix on the same object (upstream
  b39a1833cc4a, backported as 446beed646b2, committed 2026-02-06)
  reworked ksmbd_tree_connect_put(). Only the create/publication side
  of this sequence -- the September 2026 fix (CVE-2026-89788) -- never
  reached 5.15.y. fs/ksmbd/ path form applies to the 5.15 rename, same
  as the earlier backports.

- Severity per the CNA metrics: 9.8 CRITICAL
  (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H). Upstream KASAN:
  slab-use-after-free in smb2_tree_connect (smb2pdu.c:2872).

Could you please queue the fix for 5.15.y?

Thanks,
[bnomran=E2=80=94 scofaild23]
