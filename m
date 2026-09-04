Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E89481257
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523916; cv=pass; b=ZOAwjH28Qi2z8Evq3DzY6ojDb5EdY3ZnJr82lHOYYSOatD+hm1mCQwiHKxCIsKVix28Sr9u+AQhacbnCJKZz+qfPW03zwAn73sv+icitew3SakkZjdO1WtghATfCfF6gFLluZVUuuOVlUtEis9QDXu8CMwdjALHH0S/D9utRTVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523916; c=relaxed/simple;
	bh=3XOzfiTaTl8nssaYUzhNxyvEpsxLzFFqpUF+v1dzuRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGn+onaB6tAzQhVTt5EdjFxi27pwoyjY1oGruTvh2V9pb0brnMzpk6lQSIuNp4FB2+qz/xDpBrwmG9gsQ2GFdQ9Q4I6U9ywKREtM/Gfnmcz5sa7vZBU8kkKBb76g2oAvAOCIYy+CY8VuUA+BV4MYbF4Y9bnvWp6uUMR7AXfbQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1JgrpZP; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1JgrpZP"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a40bcc8d69so742962b6e.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523913; cv=none;
        d=google.com; s=arc-20260327;
        b=hzalhNZbLrWHLWq0vM5+Ct035gxWep0aeCmF/0kj0yf02hQkmqAwJLxHaD8q6z4H+J
         GXctS+mn5PzGJiwANft8TBzzo8keFn+UamKtlAYXT6OcpToUgp5ZUW8GwxJMSGCIkGKz
         5d1C284h7Wp3lMczdDQvjrtI/myTZq97iAdsvkmlRAAtiTnN7RBIaMOiEvEQ4lc93x2I
         FnBu5z2Ld6EP5iDsgA+1HV4QQ6PhPok72KLc79SeyjMTzi0XNCQ9Gl7HEERflfTM39il
         ICWcS4d+LwFdfaaZ9JQoIeIzKWJAx3CVBWr2ZhsxLmNpvoTmFqPPmOHwgR7XNOqMImsb
         YPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        fh=+uEHIO26AFtsr8J1FLL5wZMdvBJv2laSeUNu50MoMxg=;
        b=ltQBjVSHhKPiWvENvYmAOC4osH67lpAQ52lC+F1d7mT1bJ32ujRMKSbsaCMeA4A+RG
         BhUeDeT6eVGJmqBxsCsvYwfVv7iIEnJ1s7k3O+E27IzLHOuio7UeaZA2Lf/OEXN0fDk4
         QaWG361euwYK605ZHh3E3rqOND6MSQ34L22agrJ42fQwNRd8hhLcNyyGPqWxSRdUOtzO
         hmAyAVShsMX2dpscXOCdcX4cGUzFJ+hD34ZxcghwAwzAmtFHWt4Gq8CNomde2WA2S6Ic
         Sz5IbJ2ycxKbKJ4TyxEJ5EdHx/Za74OasrSlAtcD+7oCJoT7jwbYODTY62JcXY9wTsAz
         WUlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523913; x=1789128713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        b=V1JgrpZPRDJA72Ll7RrPY2BejpIHUpjk3iV333p4apWdy+kM71sujO2eSBhdxwikgx
         qHPARe3WUscX03Bhc2HcNvIMb8fWyEHSLqlXc9oDPgHVSk4mt1C83HnjF7rfhw2J3qDl
         G2qMIqj0WMgGTSVdyWbTz0bAYMzE+5oX+dv0J/oZFFB2IPcrroF/zcYW7Y2V+vGQRAIJ
         tOv2zmpUxWsS0vMAtlkLw4T/e9B2RlmU+gLSieMq75P8Gn/4mfhv0QwVoWcJOUiKHLsM
         XAa9ECSeA4mGSXZWzfRmP06KBgS3g6gjIRWCwYJPtXmxL7GXamQ8ESOQIq/nqOJiUbv+
         M50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523913; x=1789128713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOZ+/s7O1II+LBybpAWTVkJ4Q4aeE/04aKXYIBgsGyA=;
        b=KjDa8bG8/rr83R4iQc1TjQ2RIOB3ZWDfwNmMHwkO0v/rY2cIzlFAQsEeu9O5l3s3No
         tnV4YSwgbSAfqGma032nUVuWU2h5hF/4d+piwifgMiKGelvOJRt4u45hKwVUJzjzaUuL
         qGg7EgmWi7bDCwKsqzbplQQ8zvwtrahnu+4Rwu95Ba9/Gb6B6KVBEOqJVjlo3R3puNVE
         0QHFb39piSs17N6YyPgusrWOO8T3OWTmEeF8LuMd2FKWcW+gvZPNfBDxi82rr9dyW9Ue
         6AezH7JxNyVzJi5wuq3rzmT5XeYOEuOAQKI5MEW8wkuJfXW1TY3ITG4JlPJRgAMbeNTr
         EEcA==
X-Forwarded-Encrypted: i=1; AKwUvBxX5oSKMdH5+lvW2YDseePaab96FrRij7QJ7vZ0VPxOJ6afhg6nJB4pQOivvB+zXZdHqVbxitI=@vger.kernel.org
X-Gm-Message-State: AFuF++nrWYP3Xfc9NcJKOIE6zYuXwvuni3Qx/Ku9zRN//zfMLJ0Yczgh
	EDc9i7EYsTcJLlCPBdIpJZJ7HrkfnejWbZfOFH4kXZAAy9OpFCb6r99ayOXEsMMlr9OWF6z3TI3
	R1+9nKsfvB+NFbE/Hds+Fzn+d+Vj9WKc=
X-Gm-Gg: AYBFou3LFfAgvyfDDcQ7XXG/t2n+zA3KW4prD6vQeQwZL/Tmhobcl1iuC+fHCtPXvFO
	hS7URAXMTBWNOQYi9gUgBIJ+fqCg+NLRlf4N/K5L045yoVCWGHk+MFdErsaCD6cMnekQFnxgF3w
	8TMPGRFEiaseonvD1vPT8oGCXBG1hJvt/kbYkMXtPVfGfCLupGSEiFZPBfaco0L456NKAODRnHT
	BucBx/ViqEbm9845Hf+87zPQyp6NHMBDmlvrXJGTIRtprWF4Iw7nBq2xNcmwqHLeNi4qViPsBeS
	UN/IJX3eQj8b5iVfBFHp53M3mk1nDgA/XbdrMme0BGA6
X-Received: by 2002:a05:6820:f014:b0:6b1:61b8:7ed5 with SMTP id
 006d021491bc7-6b6fabe1074mr4366051eaf.1.1788523913399; Fri, 04 Sep 2026
 05:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com> <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:11:42 -0400
X-Gm-Features: AcwNN1VbUdbEej1BLIUfSISJ6S7hp4UQ4qRAN1vcXaQB0HJToelq_ptidxZSstc
Message-ID: <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Paul Moore <paul@paul-moore.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Are you sure that's the behavior you want?
>
> Think about how the socket/connect check works for local operations:
> the task requesting the socket/connect operation is the subject and
> the socket is the object.  In the currently proposed patch, when an
> ASCONF socket/connect operation is requested, the subject is treated
> completely differently as the socket is used to represent both the
> subject and object.  Even if we consider the socket's label a proxy
> for the creating task, using the socket's label as the subject of an
> ASCONF permission check makes little sense as it is the remote
> endpoint that triggers the ASCONF operation, not a local entity.
>
> > I don't think there is
> > precedent for performing the socket layer checks with the peer SID as
> > the subject rather than the local socket SID ...
>
> I think that is because all (?) of the other socket layer checks are
> initiated by the local system.  The ASCONF operations are unique
> because a remote node initiates them, which is why the network peer
> label is used as the subject as that best represents the remote
> endpoint.
>
> Please feel free to put forth your own reasoning on this, a discussion
> would be good, but I think we do need to recognize that ASCONF
> operations are different from local socket operations.

That seems reasonable. Wondering if this change will then require
updates to the selinux-testsuite (or if not, we ought to test this
behavior too).
