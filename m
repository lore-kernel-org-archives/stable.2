Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C32F7EE0
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847738; cv=pass; b=jtJm3dMK5T74+I4B0u1hx1Phmrxryde0QXbzxuT6ktxQzdtAWpkUPu+WRS3CBB07rzM5uVEEBm7IE6i1nxE5Yhf1p/tR1wWuKWodAK5pXW3GAcUYXpCMyJmGeJksSBWj0bhJ6MoCOCOyfzU6rH7eihxn4ApfMTl1cjBY094If/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847738; c=relaxed/simple;
	bh=Ypn/sllLHY+q691coE2q5hvwYIfWukXrF6EaTXqu8+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyRuMt+Azi142mtQ1NOYtPQ4hdgMzFQOBe8efcks1c567jLID/oOAyqNBKtvTuXTS9xtOXB+KbdflvP8r2KL0P73l2upzCnGU1bJIQdZ+Gl8dO0Q8hMq5+Ms25UnZcuaBpXB8gWWw0wFxt+7QbNdkaEEO91D+DGKx/VD0LK5Wm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+JbqdSR; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+JbqdSR"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ac8e048735so15528237b3.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790847735; cv=none;
        d=google.com; s=arc-20260327;
        b=CEO9tCA8JfjJodWSdRESQc8VOQLh8jgiqXomn6SpwXN6VavlrzWtHGP7+VsUinpJwQ
         AhU9rJQuNLhK6oTH6beYXBkKk3gywf6xhIGraGjO5nUSNaTBpbSLVG3ptnNBWQANuaNe
         sojzNOO0fTXANWgvnZDRmTCBWEDO6KU2REj5I2NqIGfy5XBOueNo2jRs7ELY3TXQ/aiq
         VwCzWPDtFo86TRloNUTfbZJn0DdP8Dj9ZgwJGsgt2HCzGALdMV5sCjSPPHouGLM84Cu/
         kl1Rvgd3vjLGqGP5GC7/tbQ4ROOt8zNGRUUMFAdcG3QLnoMas8Nf27x6EGMWW6JtL6g6
         9e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cp7MMTlo9Epi7EBkM5Wv17VJLo8EMbC/QdZsdYaWY6k=;
        fh=LFV86uyKo1z6KxM2uT9tEoYygIUneymYmNhk9NtYKqc=;
        b=NOOTqOa0viag2J0oPDNCbknOmSLyXv0SsJ/+m4hZUawromdXuEJg5WrvfSlGL65QnZ
         uhOjTlh6lJLmYe/0bYJFuYXysr0XNwCCLm8f/X3w3uHtoHufHmaGkM+DJIobqy1lf3KD
         CyrZC2bBXNig2WrR+1JPf3+aOFEu099+QxU1M9n4tH+cGnJiCiRNXLJPVFlAkzd4TUWh
         0w0eOjB8uwtd7cpHF1qVH0dGPJbDSbsKA97glLLpnuu0/hos5XEwMS8Ju3yMB/Rti5ks
         Z0HWxOaG55OTLF1jdpVJQbS8u4fwImnwhyUngnMEiaPOoPdvHuzsQJDJxF5scMc8rNo3
         sieA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790847735; x=1791452535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cp7MMTlo9Epi7EBkM5Wv17VJLo8EMbC/QdZsdYaWY6k=;
        b=W+JbqdSR8F9PLSOnTF4RTv8RgWo8lkpWcw60oh1/BB1aUf1qaxfXhTB/DMmVQfGm7U
         B6rXDYTQxhgj/Roon4r2cOCLkG4wIwNeyPkVsu4FZKxRideCqdNnupEOsapz6jTl7ZcD
         EJuoxZsam480p1suwM/wv2c4Z6oNKw5WrABozTDDN9mdWOinZCWfPUYbjW4MRYw8LE5y
         QarXMKRmLFbVgy8J237PHKZLCHafupcRTiz8ADoYJWSegFR8rTwUwdBG2ADTGVLV+pTh
         4e19iMD2fhJ0dUbPgTNMJW9OdbxFskKP0J0wh5ZpLTDqcQnYgZ7Pq53j5t706ffpB8dO
         dUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847735; x=1791452535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cp7MMTlo9Epi7EBkM5Wv17VJLo8EMbC/QdZsdYaWY6k=;
        b=Hrngurds8BpbXfNm5f3kwbCG+e1FXYp6cIumSo1mkDk1+bZ7QYiZzIE5UDs+M4T1Wa
         I1bpUsSmexinpq4UK9ZuWInuesmPstNo+J1ZcRgg7ClS9QduG1TaKuMBJneH7wIrmp4t
         9wVcv1GFyfFs7//2o4xh5gmCJLdDSb/ZDWuDsul3NkgDEcJQ8VFEe89i09Q6ajsvGIl4
         RVIcOM/48oOWlbYXsxSEPFBVfExk1ewA/iitFJH4lJImRaBJLIpqur4YKRuK5fx9JJt5
         42aRJFcQyRH+xILAsKKCIzh3nu8KS6flJCjzn+gZXjkaL8G10UBjGnpEg2R5LVLkkt3w
         yFtA==
X-Gm-Message-State: AFq9FYIBOoAVG/ig/ENQoiasJFywVK9+MeSYFho/zbqbmf+QKQrOZ1I2
	ChBhqnr/QaCgL6Rc7KWm4BvqUSMCWSSCj1wFO7DFreg0m4spQdatTyNGFKhWs81rn1qZtPrNo+S
	VUelpYGUVhDIGGVxppHSLhW2k2ucFEf8=
X-Gm-Gg: AYBFou1So5zHGQOAXG2y+7DQJC4jG6CACoIYDhtMVLSuiocm0EMPlsBLuo1Feo89dUM
	x4CqUgmGNdP8+a3cieeXxMQiZHLRgbHUyjN3tVtxVXvkVtKQZkFQzGxGE1hp0EghlO6lWsWoczW
	6I8QtAJULiVaGvmQidIdYAZjap92m0G3ApvcqR2ejr2/k617ucYWB/ZgESHL4j0V1a46HvNKVdu
	EYGtaRGIAhPgiC+CwQ3U1ZfBodUVVNu5QOFcqbyOU79czNDVlnuHmIkAQ+m0ZcRykg+8Zl93ijo
	Io8dJb/YpVuxtJQcoGs0sFEdP40cuj+iwTfTuSxZrkKqkZj3+8oh648=
X-Received: by 2002:a05:690c:113:b0:8a6:1901:30d9 with SMTP id
 00721157ae682-8ac93df3db3mr14307357b3.37.1790847735347; Thu, 01 Oct 2026
 02:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930152414.738996857@linuxfoundation.org> <20260930152433.381204859@linuxfoundation.org>
In-Reply-To: <20260930152433.381204859@linuxfoundation.org>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Thu, 1 Oct 2026 11:42:03 +0200
X-Gm-Features: AclHuK-JLWPdhKydTxrm6JLYXSIGwu6I_U39_3wTrHQIdvuK301QhQ_vWvJW0zQ
Message-ID: <CAFAa3YBUKBAD4cHHO5PdMauxLJ46V2_9SU0U=FtnZjgKP-o1Nw@mail.gmail.com>
Subject: Re: [PATCH 6.12 864/877] rose: release netdev ref and destroy
 orphaned incoming sockets
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, patches@lists.linux.dev, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks a lot for queuing the ROSE series for 6.12.y and the four extra
fixes for 6.18.y.

One heads-up on this particular patch (commit df12be096302), before the
6.12.y release goes out: since it was written I have found a regression
in it, and the fix is not merged yet.

The problem: with this patch, rose_heartbeat_expiry() reaps an incoming
socket that was cleared by the caller before accept(). But the skb of
that call is still on the listening socket's receive queue, with
skb->sk pointing at the socket that has just been freed (no reference
is held for the queue). Then:

- closing the listening socket makes rose_destroy_socket() walk the
queue and touch the freed socket, or
- accept() can hand the freed socket to user space.

I hit it on 26 September on one of my live nodes, on a 6.12.94 KASAN
kernel carrying this series, while stopping the FPAC daemons:

BUG: KASAN: slab-use-after-free in rose_destroy_socket+0x24a/0x570 [rose]
Write of size 8 ... by task fpacwpd
rose_destroy_socket
rose_release
Allocated by task 0: ... rose_rx_call_request <- rose_loopback_timer
Freed by task ...: ... sk_free <- rose_heartbeat_expiry
refcount_t: addition on 0; use-after-free.

followed a few seconds later by a page fault in the re-armed heartbeat
and a panic. It needs an incoming call dropped before accept() and then
the listener being closed (or accepting), so it is not frequent, but it
is a real use-after-free.

The fix is "rose: hold a reference on incoming sockets queued for
accept()", with

Fixes: df12be096302 ("rose: release netdev ref and destroy orphaned
incoming sockets")

It is pull request #25 in linux-netdev/mod-orphan, waiting for review,
so it has no upstream commit id yet. It has been running on all seven
of my nodes since 26 September (6.1, 6.12, 6.18 and 7.0 based kernels)
without any recurrence.

So, as things stand, 6.18.y already carries the regression (this patch
was part of the first fifteen-patch series) and 6.12.y is about to get
it. I do not know which you prefer:

- keep 864 in this 6.12.y round and take the fix as soon as it is
merged, for both 6.18.y and 6.12.y; or
- hold 864 back until the fix is available. Note that 868/877 ("rose:
don't free fd-owned sockets when reaping in the heartbeat") changes
the same reaping code, so dropping 864 alone may not be
straightforward.

Either way I will send you the backport of the fix for 6.18.y and
6.12.y, tested with "git am" on both, as soon as it has a commit id.
Sorry for not flagging this earlier.

Jakub, I put you in Cc only so that you know why I would be grateful
if #25 could be looked at before the rest of the pending ROSE/NetRom
pull requests.

Thanks,
Bernard Pidoux, F6BVP


Le mer. 30 sept. 2026 =C3=A0 19:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> a =C3=A9crit :
>
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Bernard Pidoux <bernard.f6bvp@gmail.com>
>
> commit df12be096302d2c947388acc25764456c7f18cc1 upstream.
>
> Two related cleanup gaps left the module unremovable after a loopback
> session:
>
> 1. rose_destroy_socket() did not release the device reference.  When
>    an unaccepted incoming socket (created by rose_rx_call_request()) is
>    destroyed via rose_heartbeat_expiry(), it is removed from rose_list
>    before rose_kill_by_device() can find it, so the netdev_hold() taken
>    in rose_rx_call_request() was never matched by netdev_put().  Add the
>    release at the top of rose_destroy_socket() guarded by a NULL check
>    so that rose_release() and rose_kill_by_device(), which already call
>    netdev_put() and set device =3D NULL, are not affected.
>
> 2. rose_heartbeat_expiry() STATE_0 cleanup required TCP_LISTEN in
>    addition to SOCK_DEAD.  Unaccepted incoming sockets are
>    TCP_ESTABLISHED, so the condition was never true and those sockets
>    lingered forever, holding the module use count above zero and
>    blocking rmmod.  Drop the TCP_LISTEN restriction: any STATE_0 +
>    SOCK_DEAD socket is orphaned and should be destroyed.
>
> Together with the earlier rose_make_new() double-hold fix these three
> patches allow clean rmmod after loopback sessions.
>
> Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/rose/af_rose.c    |    9 +++++++++
>  net/rose/rose_timer.c |    9 +++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -363,6 +363,7 @@ static void rose_destroy_timer(struct ti
>   */
>  void rose_destroy_socket(struct sock *sk)
>  {
> +       struct rose_sock *rose =3D rose_sk(sk);
>         struct sk_buff *skb;
>
>         rose_remove_socket(sk);
> @@ -370,6 +371,14 @@ void rose_destroy_socket(struct sock *sk
>         rose_stop_idletimer(sk);
>         rose_stop_timer(sk);
>
> +       /* Drop any device reference not already released by rose_kill_by=
_device()
> +        * or rose_release() -- e.g. incoming sockets that were never acc=
epted.
> +        */
> +       if (rose->device) {
> +               netdev_put(rose->device, &rose->dev_tracker);
> +               rose->device =3D NULL;
> +       }
> +
>         rose_clear_queues(sk);          /* Flush the queues */
>
>         while ((skb =3D skb_dequeue(&sk->sk_receive_queue)) !=3D NULL) {
> --- a/net/rose/rose_timer.c
> +++ b/net/rose/rose_timer.c
> @@ -128,10 +128,11 @@ static void rose_heartbeat_expiry(struct
>         }
>         switch (rose->state) {
>         case ROSE_STATE_0:
> -               /* Magic here: If we listen() and a new link dies before =
it
> -                  is accepted() it isn't 'dead' so doesn't get removed. =
*/
> -               if (sock_flag(sk, SOCK_DESTROY) ||
> -                   (sk->sk_state =3D=3D TCP_LISTEN && sock_flag(sk, SOCK=
_DEAD))) {
> +               /* Destroy any orphaned STATE_0 socket: either explicitly
> +                * flagged SOCK_DESTROY, or SOCK_DEAD (covers both unacce=
pted
> +                * incoming connections and listening sockets whose link =
died).
> +                */
> +               if (sock_flag(sk, SOCK_DESTROY) || sock_flag(sk, SOCK_DEA=
D)) {
>                         bh_unlock_sock(sk);
>                         rose_destroy_socket(sk);
>                         sock_put(sk);
>
>
