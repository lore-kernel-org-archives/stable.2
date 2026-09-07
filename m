Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9839231842
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808530; cv=pass; b=UxWLGE8c4USHIdl1I6oEvJxfuYANNbQsk+JXNvaJ2dr4mYpnHGXCT6OSdCAMdCGGb6nBmiFZAspFlC+NT7/o/hdGakZYPvTC69wkgWPo+/Ktg2uqIwbbVL0BR+6Y+o7BYzRBbD8SsHYzTyDguQN4QAnn8Ux8Cotc7LuhMX94bTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808530; c=relaxed/simple;
	bh=x5vPF2zdApbc1bQDHCY5MbAFgU4op6PaAJerhpeqC0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsfnK1R3rcWoyvGC/lUFPSdIg7iAsgi0Xcchxcrm8CoyTQxKhKXs06k+43vY0hvFI6wGN9Y62rEthP3oQvvnO737EPv3WQD1JTdUWg/r/fBu+kY0I3U4wrb7GfijFmjPzKUMW3d1UdjK+KCotBVS3ei+aPZAbccJfbfESaqp4hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cutZm4vn; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cutZm4vn"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c247f6687dcso606866166b.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 12:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788808527; cv=none;
        d=google.com; s=arc-20260327;
        b=MpJrSgqyswjU1B12ELqqvSaYGeTJckrPLE+S5jaMmPR9jMmWmvtYj7hgFkwLZggQTK
         wjyxSu1tPY3aJF8qofjxVLtI39dou8C+OCt5PMn64W5wrk7yndRtyMxdEVVZKbse59RA
         GJQTmwfo3BUT//6CHntIgCc6rp5IfZA34ppZtAv0Qg13loXLLAVxeakwK8EGrCIZQCJb
         bmwNetz8UoPOHo3nE7pWjfzr/o+wzE5yeg6njOFET+eqULpalWK3xcnsFWGuBS+/j04R
         80qDDuFO3uwEANG3Nuz+uSZyJPnoW8mMTb/xODZMgsnFc5DAD4HSwrBXO/2nB9yC3XYC
         gwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        fh=NAtPF3Lsvql+eWvrsrOzD6uufmL18OAjWijTkKyz7MI=;
        b=seM5DSOfoBb45AnK7Sen0xoiUAHV9r1MjWUshImfBugwCo5oJBoOeU3wna0QEIKCXw
         d/YpsjWdWICBv6MKUuJXPWYWLuK90pAYEOM28WfL9+tlJ06d6KWtEedLHbjxUohTkTyA
         rmYlbRUCF81HLq4ebM0Wr3/GLHidGfOr1apmMrG4xvAHLTpO4Jna0AkOzzqpp5zFOdZV
         Cx9roPOcUkyfTKOiIes4TFJI6k10t6wuchSc3JZtUlTcT4EL0QKlqkHe4XaQMm3NopOZ
         nphy3EUm7kimS0aCs5Lifnosu70qaTH+/trf790Fs2hLbpTL42GRoXbx0ELNB+FTmFhK
         OpBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788808527; x=1789413327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        b=cutZm4vn5t2JZOR9OMgI6pnmqYqQFfvcFwC63fGWUTWiVKer5VjKXFZo8dC1DLyJgA
         JeaS+sEUqPRQeejiN6VA+HRNH5InkI62g5gY6mmT4CmtIqHG3xgxoXiVxzJrA8AfN0/X
         /abBW0tO2dEig72VExEuxJTYAu5kRqLLxm8i6HRQ+0VTirB8F8uoubAZj67hfsLNw96O
         BBkaCVu3HHgzHYwxIfgyb4hT1cNZpUfVBzhzLcCIKbkSzu9yi6m3fqa158hrCnkcD+6d
         LxrtoCmbP+P21eFmt622XvDz5NLoRzP5zQTG0Ie8ErhkuFy5FGiCglCwIO/NXF6EPF8Q
         AhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808527; x=1789413327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLZ2agjLMgvlPAn6cdRVBCiOCyjFQG2uOoEUzkcYPBU=;
        b=E3IyMV6WGxdiOUa2MtXw0QXwwt7im+JyjOqsb5M2o/vn0CLQZIzALVUPdGahwswN0b
         0bh4D7uQgjnQuFGcdNkSUtKFS3dnbQuZ2HS2xuoA55W/WGVLLIEo92KNcO0SfdVMP+lP
         MsDgtRFv2Un9Ax8dfEA8svFzujlvoNsgXdfotGLG9X2NaKq2OMtiBJ80YSbRg816Dert
         LNvFDMZGkyhcvkbtH1gYfD8RaKpeeuTpaV7U3i4/DikKyDDKi7g+vfCa90mlHDWgN67y
         uH8jkTwsRFuld/OUzO6nP8QzvcVElKDQzf4Y2sQ3lGEtlR6ecI72nB5w5ZGxBAzYR9ul
         a96w==
X-Forwarded-Encrypted: i=1; AKwUvBy6KpVTks+s6//XQ065/FSaSsJR615MaSVkZzeko792lZygdegyPLaWTgObgynDKzUjl2t5Vg4=@vger.kernel.org
X-Gm-Message-State: AFuF++mcN6v6BTcRLgTFUBcGZHo56zlCt/4lb9XZuzfIUpLb30goa9eO
	OBJ5gT7RnvDJ8uPQ0R4HyzqxEOmsZtSkXLsyBJ84AOr2FVGebWLwxxOWrZPzQReEZ4/MU7uA/b5
	9ZDxT3Ge8IgbcgKsIwlEF+w3AjT+/fxZkR4/MI7rXYg==
X-Gm-Gg: AYBFou2CSvuYz/pzU4offbgjZS4fWk3qlGOoHE4T/gu127Sp/AM3AB9P1EPig55xyeA
	UaCaszyCPvztWa9gqHItx3Gpg2U8LSDiBvRwEAJMPUprcCcb4CCwgM1AEAC3VOAwEoDU71H8ss/
	Xgnrp3cGRuXcnB+6iIO+I48zOsE+uuWeEQCcIZlvUCAZWKLD8Ta/QlTzEP9GUCub/igXrcSSvkP
	+K+Odfrlh5IqK0OZyR1zLTjDLlrNH+W3K6SE+ZrDWqFgVixE6ygQle4dSTn/THATIzca90T2rKu
	FEmabmVgs/jK6QpRXbG9dWz0Ke4gtyvJCLhJUmBGs+GR0jm0LvRkZR7gUukel6fjI2qgpw3Lxbj
	LScLpdMLQ
X-Received: by 2002:a17:907:c20d:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c260c9f8920mr994472866b.17.1788808527122; Mon, 07 Sep 2026
 12:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <20260904150304.49104-4-max.kellermann@ionos.com> <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
In-Reply-To: <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Sep 2026 21:15:15 +0200
X-Gm-Features: AcwNN1VSJfSMfCn3vuBaXzqEcc2QZfWjSUijicTPAmQje5KrNhk1pl3uBSLDJng
Message-ID: <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Xiubo Li <xiubo.li@clyso.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:56=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrote:
> Just one remaining teardown path still unregisters the session before
> removing its caps: the fallback loop in ceph_mdsc_close_sessions():
>
> mutex_lock(&mdsc->mutex);
> for (i =3D 0; i < mdsc->max_sessions; i++) {
>         if (mdsc->sessions[i]) {
>                 session =3D ceph_get_mds_session(mdsc->sessions[i]);
>                 __unregister_session(mdsc, session);
>                 mutex_unlock(&mdsc->mutex);
>                 mutex_lock(&session->s_mutex);
>                 remove_session_caps(session);
>                 mutex_unlock(&session->s_mutex);
>                 ...
>
> The rest of this series consistently changes the ordering to keep the
> rank occupied until remove_session_caps() has completed. Is the
> ordering in ceph_mdsc_close_sessions() intentionally excluded?
>
> This path is not limited to shutdown: it is also reached from the
> corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
> and handle_snap(). In those cases mdsc->stopping may be false and the
> mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
> __do_request() can register a new session for the rank in the window
> between __unregister_session() and remove_session_caps().

I don't think that's true for the call paths you mentioned. They call
ceph_mdsc_close_sessions() only after ceph_update_snap_trace() has
failed, and on failure, that function always sets CEPH_MOUNT_FENCE_IO,
which prevents creating a new session.

The only other callers are ceph_put_super() and the mount-failure path
in ceph_get_tree(), where this is not relevant (no requests exist).

Am I missing something?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
