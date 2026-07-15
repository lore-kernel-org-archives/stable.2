Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20052F83A2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130790; cv=pass; b=sJD3zvqL5PnI0dKPVxdZE5dBsBBSU5j4x432ST0q/zb9RakXIeJBAIAlNwahw55P3I+VR9twAhM0M/a6XGA3E+otG7VVBtoPRRxf+jozTdjdTiji/sB4q+2bsc7qS/ahEHO9yd6Ap8X45CtF6JsEi9mditYAE/w+qbgvrtFaNZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130790; c=relaxed/simple;
	bh=q6cKBZdpYUeBw2lS1ypmmwqf8CCdyOQyy3KXC5MRLFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf7vUG0Q9xksEr+dq+8W0TDwSwtz9UDYjKrMFTcVgcS7Ot7wd/tMMkjpRq9xd97I1p6cHGT215RGFycPwEx0AFDkLYq/aAA+4cNMyqdnnPY24BNucIiOejRTritlezehTpBo7OhH7W3RnkalppHDh5SrFuK4HXP303Q8S3dk4Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOkDxUsf; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOkDxUsf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47d70879764so3888798f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784130787; cv=none;
        d=google.com; s=arc-20260327;
        b=GrYsq0sLlmQSN5vsfD+EhtBdPLNHRwaFqscR/zaywlsuhUoFrB99DR9oCCWK2ILKYV
         d56DvtLpXSMoI7AN6CDQHkmTzFUoXO6FO+7D0YglS76PtU8sjeK1Ikw2CVF9K+uqO2Et
         zzEdSz6bZ6JQqIHiEmUEX8vZnEXqj66RFlze5XCjZi8PGnyq2IrUKldmLjX5A7usegyj
         2A82RMMPmDCDHWgf021sv6IDygh9SSXtiFEf10MdCSom5nIa3KaOxeLq5lh4Z2kmusUF
         N00fc6V2TxpOxwHDrDmMbaUx9/K9Oy4AbrhmrQfBUBZO6EM0G2pqL0b6z6rUtLHsXW+z
         Idqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6cKBZdpYUeBw2lS1ypmmwqf8CCdyOQyy3KXC5MRLFQ=;
        fh=yot06ohHDGxYlj8CjDInwR6x9PQSjVYTA4kD7Qz8yXg=;
        b=oo90QWneEHmRYK8cphaqLm1R/B3KGSzMxneaGvPX/Q9mQhnsbUo6fCZjmlGzmD9y1x
         /xTNMi9QRS8Spgo6+Rv1mnTSHuLwMpVuwHjj51q6aNv+v67w4uShXbv/bZ4NGwOflFOY
         WGIjSr3kbHExq3Xot0k3JT5Ar4bEVtf3dJCQ9j7XP+SgW2qhfeO+AcBiTzeWRQyCs02D
         b2nbTxK+TZLRsDryuhYqiaVcwQGBqViHKhsxAq58hX7eh3uhaUn7XEe/PMFGtqfDRwWX
         GNZFiBa0Op0TzugFiPy2EzE06oR4HfjZNk5u8kwvg+hufxoeAGcdvd/yWEJBautgD+sZ
         MClw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784130787; x=1784735587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6cKBZdpYUeBw2lS1ypmmwqf8CCdyOQyy3KXC5MRLFQ=;
        b=DOkDxUsfNStkip3DrRDrAHdhv5rmX/EjUtCQphl/7Nj/c46xMOLfXg80Ly9foIrrkJ
         aW4GQ+4y+lVtMM5fIiKMFT5om7Ub/ERiXAwT4/HCqC8r2zGhrP9pevxql+vdHizXfepH
         eAtGDAr8Z9OI8kr5vvBCQ7lE7IbG9govLgeFAM1NUAZLrloTlSnVAubalL57cqhFfSA5
         0QPrX7zMvMUgpuwq8rjIYO8S6Zh/wfCDU+qr0lzPdJGH0p/x5sy2qKOa4A1d+D5jASOT
         IRuqO7FhIdkAFVhCiaqESBvbcjKvGIJy6doCsHGEwgkx99oY2sr57fZF6RdS2KFuc2Cn
         rflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130787; x=1784735587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6cKBZdpYUeBw2lS1ypmmwqf8CCdyOQyy3KXC5MRLFQ=;
        b=eFMljs8GT0nC9r+qnhIBEVMzFXd3zLQIW65La9Bxz0NReUZETKgKAMMveerzqoc+9E
         mUClJMJnslJl3Mx6Q9kHd3MFm1a7rGKohKCB/l2R422yfhrFQi51zQkUOBUwQOgi1fY6
         cvRV1VMEIGuHjqrI/xBw+QqeFhz/MtDjMI/L5QehNtvzH9bMxEK3y9JRxVhe2NM1A6lE
         c6Vwq6pGoJg5HxVl31GvyXwaJdwaMARD7u82XLqOb0WCUcks6bUS66/3aQgYFlyPIcdn
         XKT9k7xYIqJYkDstQAm0dYaFTKX1FIR3samkSPHT1Xf/1+DsZ/T9yEqv1yOUGwwOhgSh
         buag==
X-Forwarded-Encrypted: i=1; AHgh+RodJaWa9edT1thygozJBNp3YESYokNJp3OyeFXxnBWX0J9Tv8sx9qaMG7vAHlrtKzSjL5NWItE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl5cByxa27G82IOUiw/MzZucn2ojorgqasT01L3hmZDAXgG9H
	WSpeMsJ51ocGMPB73OiFqRmVFMAm+/ylcZzK3YjIu52hgVXzfkY8BvrmA9IsnCmD+YXBP193v58
	3Rzb7OOu/tXeBc1kjqIs8Y8FPoekUwQY=
X-Gm-Gg: AfdE7cnLkukQN7UyFgEHegwkQDWzrVcnyAyWmSs6t2BS7HQNZ5xmLksjAfXfEt4+7Cm
	UTOy5Y6Lp9K2si5/0mPE83AAy5ZW7xlcBe58QoVoJ2+B9oKLn6bpZ44gyWz7rixAH+Qspr5wh4B
	h/GEr9rPDiU0AFh9WF9cjZt1n8MI0nBnEy/bbLeOChv5IyfZ2s323BIN/YAOheL+8vFomGNLNxj
	j/bIgXdhiZWsaJX6z8IJxuv7iViv+30QsMoVNl4MTM+Z0PsZonHANuC1CGL0pQXIgDlUt+K601k
	nPYZNwBfUWK2NE1Mym4lC3nLgYulFClXvQlRnqIKzOG2S32qxJfFP2saKckJet0=
X-Received: by 2002:a05:6000:4201:b0:475:e3fe:8ac3 with SMTP id
 ffacd0b85a97d-47f4fca86eemr3714736f8f.8.1784130787042; Wed, 15 Jul 2026
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175345.2542331-1-joannelkoong@gmail.com>
 <CAJnrk1b9jjvP6a9PaYAiA0HZcJ0_dR_O2aGWPF44T2NNBJC94w@mail.gmail.com>
 <CAJnrk1Zo_j_QY9Q=jft5=fio9mU36uy5LXP3bC4=xO8DbakzrA@mail.gmail.com> <CAOQ4uxg1m0C6suUpoO8hNkgnqEH-APV3BJgzKg2biCEoC6kXVw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg1m0C6suUpoO8hNkgnqEH-APV3BJgzKg2biCEoC6kXVw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 08:52:55 -0700
X-Gm-Features: AUfX_myi4_L8KFJGelEiwEMm_-nESlXVjSp_TxBdEh6JNd5VUFZ0yTAoUU0lPks
Message-ID: <CAJnrk1ZBQQy5pwBQmDwKvumcGkUT5dhtQz=D8FwO-j2LWA-EJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: fix missing barriers in io-uring init
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, fuse-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:22=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jul 14, 2026 at 1:51=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Jul 13, 2026 at 3:11=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Mon, Jul 13, 2026 at 10:54=E2=80=AFAM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > >
> > > > These are two pre-existing issues Sashiko reported [1] on the fuse =
zerocopy
> > > > series.
> > > >
> > > > [1] https://sashiko.dev/#/patchset/20260630211436.2062816-1-joannel=
koong%40gmail.com
> > >
> > > Sashiko noted some other places that are also missing barriers [1].
> > > Will send v2 to add these places as well.
> >
> > These additional ones aren't real bugs. They're not reachable on a
> > well-behaved server and on a malicious/buggy server, the failure is
> > benign / self-correcting.
> >
> > I think we need some sort of way to help Sashiko understand so it
> > doesn't keep flagging this on every future patch anyone submits. I
> > think there's a few other places where some of Sashiko's
> > assumptions/analysis are wrong (eg uring-cmd sqe stability semantics
> > [1] in the zero-copy series). I'll look into this unless anyone
> > already knows how to do this.
>
> You may want to talk with your colleague Chris Mason about adding review
> prompts for FUSE, because he is also running AI analysis on existing subs=
ystems
> regardless of mailing list patches.
> I didn't try, but you can probably figure out how to add FUSE specific
> review prompts
> to Sashiko yourself...
>
> Thanks,
> Amir.

The prompts Sashiko uses are in this subdirectory, which is open
source and anyone can contribute:
https://github.com/sashiko-dev/sashiko/tree/main/third_party/prompts/kernel=
/subsystem

I added a minimal fuse prompt [1], I think we can continue improving
on that as we go.

Thanks,
Joanne

[1] https://github.com/sashiko-dev/sashiko/blob/main/third_party/prompts/ke=
rnel/subsystem/fuse.md
