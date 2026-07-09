Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4F47AF61
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618011; cv=pass; b=LKtytKL5CA9HQOmyQiaUlxbfRDtggCKf9t9RNKbA3UrzhJfYf7R0uvQjuMAeFlrMwnPgO+NV6IceBy5x2N2uAmz+QP5mGl2BpPP87K58aBMrvPxWfum7iwntnH6XJTgUp+Rn7kGuYh0C7pMD4Mipq6UMSSBZz1QxgPjD2CRwvps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618011; c=relaxed/simple;
	bh=44+SofjtLmORqg3rncD4AfR8KX3rsGuXPRWkOEfPD68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+6ZENJZx1iznUC/9aS1AsPwjQNNAvn1mcffYdAh/hrFnQVmZokHglx4/dvKgKsAHFxgoFG8pIJYdCZk27bP034l4ieS3PeK3sZ0jW8XE6+qP/Nt0laZD7pGG5VGhqMDd2U13Muu1Gx7UZw7f4j3cZgO5bYIXFd1pBBXwsAqRyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVfiWryZ; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVfiWryZ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ff88549786so1195176d6.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 10:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783618009; cv=none;
        d=google.com; s=arc-20260327;
        b=CENFilMWi98nXMJKKSSKs11TRk30y3v0J4nee137R3dyQMVabMwLnpgL4+F7TBRi74
         n/sW18UcCPNGtSD1cCtX8C8LSffsht6SGebGAs9a1nWbzrlGE2cxAIMsiOAVdY4WAfR7
         1FDdGAq2pSS/VL2N8qDv/UkrQChDsrNB+wYSY1kZklD/gBT0oaj2GjaX44gjEf2RfHJj
         toCbOSZix8apL5womqGWbmJwwURv0gFO5W0A2cMcrbIeM/SaRcNuJJKsOyeXhLv/B1hI
         SWW+d4Kpb2u8sBZAGax7wuimSvNC8wK2rVlVLsi2a1wqF3pq7KAf0SzBdQAwqgntdmhl
         zjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0Sb9vjaFSh4C2dHK/JIngHrRB/oD43G3vbh/5L/SqA=;
        fh=7BTIK/Kk7w1NXnu3Vkbf+kMzpgG1f2Ds0/NpaxDcLqI=;
        b=N/GYq0iMYMV1R9p015RXGEci99IXMT8oeTTfdnN3jgGyQ8/upb1uNH1XHQjsbdoPSt
         18TGU3zWkhVHzzEsJWwCqeKc+6SMWhtbh7cfJzZ4Dc2rXTALH17w94z6dYkH7ZLAbEpU
         9CsJO8Km559cvj/q97d+v1OGOoiODaIjq2pfdFvPF+tqXUZ9EkK81eXa1q5Xwp3kxFBc
         /++uGFJijH5/qzRsdaQp9YWb+V0HyB3tz2nXCaHGBepWyoT1JLFDUoMLt+duQqZIZ9PL
         wM2EQ4Sd1/A5SYdMStsuNIJSfZ/kA8rmTLjiROC3Vx8RXdcSGFAksMdWBKxKBD8CrDVq
         hY6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783618009; x=1784222809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0Sb9vjaFSh4C2dHK/JIngHrRB/oD43G3vbh/5L/SqA=;
        b=PVfiWryZ7WBFXyE9f/R/0RpHUeaxXzcZKxoWMx+A/v5AuxTE8e8tpOWL0oIiFVXWbQ
         SSKL7SENFoVAzibbJIm15qqNiu76O74lhyfyO36tlLFzrSCvm6yZ4k4WLQ4pAUPU86ly
         vWyvTftZj77CTtOADqmT03ZAmNPu5q8kjOIW3a4jRLnbvJ4JFU3O2KQYiryHPpWBJVMS
         2W9aqGtFbtqUlC9jutOOsZeCq+PAKwPm5pk5JW3mXnYDezBiLjlNxo4alJ+kdlabMCqS
         UeWIpPGNWXkNluOvb3ezNlmFT0WYJ/GNkRw4efmocnZqY0sV18wDo8siuxPUkL/qt06B
         126Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618009; x=1784222809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0Sb9vjaFSh4C2dHK/JIngHrRB/oD43G3vbh/5L/SqA=;
        b=hkjxHycR7IBrOpPkfYAu0Xvsp6HSkgbupu2gT6nd59s3Ss+SGVxeY1ovjzpOL3PCeh
         /sf4mwPqm5+knVNZZ4pl8zFGMuwEA/PSRWzDT8ktld4W62nC6bdNrsOacwb/8m5+h4H4
         4FeOi1Jw2seGXb4e5DOb+Gt/OU1JsUuOzk0qZefGwe1DE122p4EwoSa6R0PyO8JnELB+
         Uoiv928KRTnGfEeEW96aYSh6J89VU0b7rgos6Ew1/xml0npXGM8fAWMyB5pQyyVdkLsL
         m/2T8KjnjWVooIIIKausrkce8obumfG9dzovLIMmcOWJy8PYa4VQKotP31MF1LubVKnB
         tw1w==
X-Forwarded-Encrypted: i=1; AHgh+RodKO3jS9CPGPaXwuc/YrxmGLVRslWgN5S14jk+oSCa+GMuINBVyvXTRPJomCk0+ZMVaj+99tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfk8ZsyJY2ckhg0amZ3uBazVziZ+FkhNy4zLGS8u4zd1CU5myz
	t2sr+v66U3+948dSMzdHyxKV3RmNLMaqdF6P3C3rZIbbDcJ6BzonzQFD7R1f/KS4+Mqpu/hIcFl
	cYuQWAtt6xLFFKzlE0e93z5E9AxC9Jho=
X-Gm-Gg: AfdE7cmB/Uz8INoHRRsDwmG0hCpK5DMsh0oHybJItA7/V6t+PYYs27EW0cWRSVxHODw
	qpZhK8x2jot6/pRueqhGkjr4uRmVWQN24GFXpzShYRvhk6lDETWRM0Hhgrl0U1sz8HZ4ls1qOov
	A6RuVtTzQoJiQfOsjXGBDY9I6yST+iWwhV8WIIQc+5ZqhHkm085zqkpHpJFTpFgjobJZHtq2eYk
	hSUawD8ctw0BFwHBq7p4iYl09TCijO1onWIr99IR1JTfmIb8wTcp7UkldcbLtC+EPqJCh5WuHwB
	dVPFtPFcg5uet6U0vf+gtMXTndBzpEjOyD5IaFkVzDnqV2gv0ha1WWzEmEOO/XE8f4uzB7vB5jo
	peUc3MBOK0r0UAV9zdM/Z45B8ZPLgFlAdfG7OjqF/mjqWo0NaypjSlXIkHsNEzKESZFCjVVa/59
	B53OeRTOFNqxw=
X-Received: by 2002:a05:6214:3901:b0:8ef:31b6:74e8 with SMTP id
 6a1803df08f44-8fec04e6cbemr97993726d6.10.1783618008929; Thu, 09 Jul 2026
 10:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com> <20260709173628.22eeb7f7@pumpkin>
In-Reply-To: <20260709173628.22eeb7f7@pumpkin>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Jul 2026 12:26:37 -0500
X-Gm-Features: AUfX_mxnR0mimr5UIz726XrEd1tXHGcNWC8r6rYl9X-O8RuA7Y7OGaBpp4uW8ig
Message-ID: <CAH2r5mvxVh_ta1yJgciRgiCpoeJR30U3Z=SDvh+_N3nZ4x_9FA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix atime clamp check in read completion
To: David Laight <david.laight.linux@gmail.com>
Cc: raoxu <raoxu@uniontech.com>, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 11:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue,  7 Jul 2026 21:30:17 +0800
> raoxu <raoxu@uniontech.com> wrote:
>
> > From: Xu Rao <raoxu@uniontech.com>
> >
> > cifs_rreq_done() updates the inode atime to current_time(inode) after a
> > netfs read.  It then preserves the CIFS rule that atime should not be
> > older than mtime, because some applications break if atime is less than
> > mtime.  That rule only requires clamping when atime < mtime.
> >
> > The current check uses the raw non-zero result of timespec64_compare().
> > It therefore takes the clamp path for both atime < mtime and
> > atime > mtime.  The latter is the normal case when reading an older fil=
e:
> > the newly recorded atime is newer than the file mtime.  The completion
> > handler then immediately moves atime back to mtime, losing the access
> > time that was just recorded.  Userspace tools that rely on atime, such =
as
> > stat, find -atime, backup tools or cold-data classifiers, can therefore
> > see a recently read CIFS file as not recently accessed.
> >
> > This is easy to miss because the bug is silent: read I/O still succeeds=
,
> > no error is reported, and many systems either do not check atime after
> > reads or mount with policies such as relatime/noatime.  It becomes
> > visible when a CIFS file has an mtime older than the current time, the
> > file is read, and the local inode atime is inspected before a later
> > revalidation replaces the cached timestamps.
> >
> > Clamp only when atime is actually older than mtime.  This matches the
> > same atime/mtime rule used when applying CIFS inode attributes.
> >
> > Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> > ---
> >  fs/smb/client/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index 58430ba51b10..62605928d2b8 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -301,7 +301,7 @@ static void cifs_rreq_done(struct netfs_io_request =
*rreq)
> >       /* we do not want atime to be less than mtime, it broke some apps=
 */
> >       atime =3D inode_set_atime_to_ts(inode, current_time(inode));
> >       mtime =3D inode_get_mtime(inode);
> > -     if (timespec64_compare(&atime, &mtime))
> > +     if (timespec64_compare(&atime, &mtime) < 0)
> >               inode_set_atime_to_ts(inode, inode_get_mtime(inode));
>
> Should that be calling inode_get_mtime() again?
> It seems to have the value cached.

Would that be a performance hit?



--=20
Thanks,

Steve
