Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380397;
	b=GCu4y12Lcj1g4xWCur3KNN/nj7R7GjIkX5MlEon9KFD1Vcua6Vp/DORw6v9Mt5Dbr6/Z
	 V/hETUypd6ESRrQXDRO5ryXkUi4d45kZmZYL3iXj7/EuIkk1J7o8ejkeliTs1T2lBJDnb
	 74ivK/iiGbe9XRFBtGwDR6JjD25J8nYpZ2kB5VryPFGVrIJx7/RGJ+X09Bqh1TrlCDlCn
	 kYGqXAUBKufi1YLHsHPlufNG+15ORANpSzWoRQ/nUceQP+a5rMB2RXmcORHc2kdkC9zSF
	 nlTclzU00XwyArmrbA4/0Hj8CA1r7qr3lxD9ujIMlLg9Hjzd9jGFhd/gyjFC7R/72kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
	b=oyOAMjuxgl9xvIpoX/PtGXso54NZrSUPu/svJJDRKbTIhXqifruXtjdnR3yT8CZkgE7d
	 qIfImr2TyEqIxRC5OOAK+ZGqY0mmyqbE6CvLds6KpwKO2fiHskplPi7hewf97va/tW3k0
	 Nwc3PqRxvfeDFbVQ9+8+fwv9LY3CsnWaAnr4cBB/W4gjNPZtFEJJbgVGUKxr76wSDxHf4
	 XcZ4LSXfhVmzo+aZjTKZcfCmETgZl1NI+11eTj2aMxe2g0cnCacYya8DnaoEXZtmNeqMd
	 dy3vXKIqzz7WkdCinh/5mOoPGeUSgMu77BCCvUKOBtuwoNWuLDJMaShsw7YCFftCtQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifDw+EdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9327606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9327606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifDw+EdI
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c43fbcb4393so150005366b.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380395; cv=none;
        d=google.com; s=arc-20260327;
        b=bHNeQ4ZqPpr+fNuRhcNWoae7ivDhHCdsGA/Su0PkAlLHEEDdQsdT53I0dyw59Q+nXJ
         wkbAvW0Pp0u12/EDxI3en6jWpfdUbDZERjzu50gphh7UINW+F0+D+OvJNDskUjuL8MQX
         AzH5SUtsekeWG7QUMtVdlyVxhiedwv769tEw+8frz4e1LsaSbsFxfW18A30Mxwhe1TQu
         VzHhvS5+3wMZP5zkCLRbLugSIVCD2pVaQ5VhCC6PFCYWu3CDy7aOSwUs3jKe1+uoX+47
         MHrGftoy5FlNHflWCj+l3ZU7q6HADdLhzIrHflxeUaGv+8hvhP2NUvbWgJVEQll96Gs/
         h1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        fh=INLGv3wtByN7WCFzRuHQPj8tDnhJt/+rafPCgzsO5s8=;
        b=lv0DhVEoKX2zJJwt3Ghv8fD+g8jdzwbbQwTMQ6fI1lM6NB3QjYxBop/a/esW1V6Ptp
         z1iWKemFQNpQs3MjCAASp7TVFNfp687/GpDjqgZMKhMhvc93lfl3rJqXV9NbFAS228MY
         twUejHKGPrrE30WNnTZOXz6Z9ID9JrASO3/Vds26WzE9DVH8AMxZUwOPMZS+LvP4AWCN
         Jto7rqv62JJ8ENJX6oVPaEPhjEtbunwMLU95w1l30ZdYjSnyFOL/nXeLqYYlwzkkV0HJ
         /Asruc5dMxXV6nBHxDkej+hUtu6nROrznV+vC7uw+5dkqvYQhvrkFplrnhVNEynF8UB3
         ce5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380395; x=1793985195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        b=ifDw+EdIe+epQJ7z53+pvytV/Bz9e1dka8Di3d8b+CcNla0YYnpduqr3e3sLyOWLMZ
         wHXQ1imrTC/MPWq8CBnOsyUS/WN/MLcGkGNx7PM2xV5/Ib0JyCF4LPE+7b2I95rEI1or
         PSerFeC7d1MjpwS29FgRMkrx9te1JAGuY49v6aA3LEcWbwSnm0crQ4LdimC33bdiXfDL
         wCSyODExZ2G0jDQ+98o4285TFFxnEYFPII1HMCh8mBcwgapTM87LIxyBlBFyow2jhPch
         3O2tqTRpWVbhpK9Bo/MyyiHiqT91+VKH8DpBEmCh41VTEb3l7PsXNHPdebuKkF55bpol
         xiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380395; x=1793985195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        b=J7Ej1UrmFjaEMC4uvNSkkgAiRm/ylH4SKL1fWOhkMPZTNhxlJECiz2PfT/FNQ5w9vn
         agxdW3nIZrt4q5LlDsv/9T4OvqHz2kxQ3bd1fw2zpqRXQUFEKY/9a8UI18MYR/IRwUqz
         dNbPZOM1uqgySe6HxVg5R4uWK3FanWJDKJjJBso5y3S+HKTyFpXQ4OZgkbbZtvZtLph6
         COFdWKCDwqKnr7awjlEBxveE9Oo3w1dcxbZaRQ2d3CZT51/7eVfyX/2OIjj6L0lmm8vq
         1kKlY4aRq4iIWU4SFa03hZTMzHdGTc0gdZNVNZmAWLZEnRUq6eegZH4k9p5Jo8KneX+1
         2PPg==
X-Forwarded-Encrypted: i=1; AKwUvByFWJWnFxKqJx9ptSLAXIjIw+LSyhchGl7sDA1cRzUYq5nUPOYctw6c2uywS7f/Nj+fOMkBxkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYLBrij0O+WAYosPaWpMbREUCUB9uWMjiCs2tJpNv6XNup52sZ
	b2rIgeRy3Z3e+oF4JE7dyj0iiuFPuq9W7FdVRE8JCCIE4Nf4DKMT+ASUwAWpWhEptJ7AMLKh0U9
	5y3CZ0eMfdwCW/AB1sThxx+VNSCAs+KE=
X-Gm-Gg: AYBFou0mkwUl25dwi2yz1gNsve7ZWUuMqHVJ1FCWVN6w8U8rL8g2ism0YBIo5lj4BT9
	50Qr2oWO5gJNWnebPHDZF/Jc1Q2XOeN+3vg3v52yqr8GdPjiUCS0pLRATAEcwXyFoO3UHSb23dH
	pz4jc9SaK53Bkn989l0eAvVjgqqdCQPFfJppEASAPVz2Rmt03/btTQGkHZCtAwdXtvyqqREH0Bw
	xXYVnxkOU6HHgbxinnuJN44534OZnxhRk+taWvTHYhFOAidIak5rDOsoH9tqYo78Ms2Ra3z+Q7T
	X2Yu4oaSOCXSzfaPy4b2d00VX079OPqW6aSyI6Fpad1EtUkbGHaXKyRMKM1gIGJ8JuOwV9CUSUl
	t+z/eGeZEUSNZhyITIv1LpCmAFmvkxWkTA0C3peq2Fe9UoFI0y+DnzCTvpLgpY3ycsVG5Ew==
X-Received: by 2002:a17:907:9621:b0:c46:d493:501a with SMTP id
 a640c23a62f3a-c4ca7a4f162mr288456766b.22.1793380394999; Fri, 30 Oct 2026
 10:13:14 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P58Wrer--F-9@tuta.io> <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
In-Reply-To: <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:13:02 +0100
X-Gm-Features: AclHuK9oWOrrGn0HCF_l2TtwxZH_Qc4ggZ1PaI8aHfzRvMrzHwkJXs8-TFfiX0o
Message-ID: <CAOQ4uxjm=cGPnug18VuhKqiMvkWwLPNLO_TE3KxO8iLZG+veYQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: let backing files inherit FMODE_NONOTIFY from the
 user file
To: Christian Brauner <brauner@kernel.org>, Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000647aac065f11e915"

--000000000000647aac065f11e915
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:57=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Oct 29, 2026 at 10:18:40PM +0100, Edvard Conrad wrote:
> > Make a backing file inherit FMODE_NONOTIFY when the user file it is
> > opened for must not generate events. This restores the pre-6.14
> > behaviour for the fds that fanotify creates (and for any other
> > FMODE_NONOTIFY file), while ordinary opens through a stacked filesystem
> > keep generating events on the real path, as intended by bc2473c90fca.
>
> Looks good to me. I'll take this via vfs.fixes and fix up the subject to
> use the "backing-file:" prefix while applying.
>
> Amir, note that the same deadlock is still there for directories.
> ovl_dir_open_realfile() goes through ovl_path_open() -> dentry_open()
> and not through backing_file_open(). So a FAN_OPEN_PERM|FAN_ONDIR
> listener that opens an overlay directory through the fd fanotify handed
> it wedges the same way. That needs to be fixed on the overlayfs side.

Urgh! for f sake, can we just bring back the damn Kludge?!%$

Edvard,

Would you mind adding test cases (or variants) to fanotify26 to cover this =
find
and test the attached (sanity tested only) patch.

No need to hold off on the merge, you can post another patch to
add the test cases.

Thanks,
Amir.

--000000000000647aac065f11e915
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-inherit-FMODE_NONOTIFY-when-opening-directory-re.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-inherit-FMODE_NONOTIFY-when-opening-directory-re.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvv8a5ti0>
X-Attachment-Id: f_mvv8a5ti0

RnJvbSBhZTBlMzU4NGZlOWMzMjA0MDg4OTI3MWIzZWNlYzQ1ODAxMjNhNWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDMwIE9jdCAyMDI2IDE4OjA3OjAyICswMTAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBpbmhlcml0IEZNT0RFX05PTk9USUZZIHdoZW4gb3BlbmluZyBkaXJlY3RvcnkgcmVhbGZpbGVz
CgpXaGVuIGZhbm90aWZ5IGhhbmRzIGEgbGlzdGVuZXIgYW4gZmQgZm9yIGEgcGVybWlzc2lvbiBl
dmVudCBvbiBhbgpvdmVybGF5IGRpcmVjdG9yeSwgb3ZsX2Rpcl9vcGVuX3JlYWxmaWxlKCkgb3Bl
bnMgdGhlIHJlYWwgZGlyZWN0b3J5IHZpYQpkZW50cnlfb3BlbigpLCBub3QgYmFja2luZ19maWxl
X29wZW4oKSwgc28gdGhlIGxvd2VyIG9wZW4gY291bGQgc3RpbGwKcmFpc2UgRlNfT1BFTl9QRVJN
IGFuZCBkZWFkbG9jayBhIGxpc3RlbmVyIHRoYXQgYWxzbyBtYXJrcyB0aGUgYmFja2luZwpmaWxl
c3lzdGVtLgoKRXhwb3J0IGRlbnRyeV9vcGVuX25vbm90aWZ5KCkgYW5kIGNhbGwgaXQgZnJvbSBv
dmxfcGF0aF9vcGVuX3JlYWxmaWxlKCkKd2hlbiB0aGUgb3ZlcmxheSB1c2VyIGZpbGUgbXVzdCBu
b3QgZ2VuZXJhdGUgZXZlbnRzLiAgT3JkaW5hcnkKb3ZsX3BhdGhfb3BlbigpIGNhbGxlcnMgYXJl
IHVuY2hhbmdlZC4KClJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoQW11dGFibGUpIDxi
cmF1bmVyQGtlcm5lbC5vcmc+CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjYxMDMwLXdlbHBlbi1hbmJpbmRlbi1udWxsZW4tYjI0MzJjZWUxZDEwQGJyYXVuZXIvCkZpeGVz
OiBlYmU1NTk2MDlkNzggKCJmczogZ2V0IHJpZCBvZiBfX0ZNT0RFX05PTk9USUZZIGtsdWRnZSIp
CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3Blbi5jICAgICAgICAgICAgICAgIHwgIDEg
KwogZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oIHwgIDkgKysrKysrKystCiBmcy9vdmVybGF5ZnMv
cmVhZGRpci5jICAgfCAgMyArKy0KIGZzL292ZXJsYXlmcy91dGlsLmMgICAgICB8IDExICsrKysr
KysrKystCiA0IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Blbi5jCmluZGV4IDZiMWMxNGU2ODRhOTMu
LmQ3ZDlmY2M2NjZhYjUgMTAwNjQ0Ci0tLSBhL2ZzL29wZW4uYworKysgYi9mcy9vcGVuLmMKQEAg
LTExNDcsNiArMTE0Nyw3IEBAIHN0cnVjdCBmaWxlICpkZW50cnlfb3Blbl9ub25vdGlmeShjb25z
dCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzLAogCX0KIAlyZXR1cm4gZjsKIH0KK0VYUE9S
VF9TWU1CT0xfR1BMKGRlbnRyeV9vcGVuX25vbm90aWZ5KTsKIAogLyoqCiAgKiBrZXJuZWxfZmls
ZV9vcGVuIC0gb3BlbiBhIGZpbGUgZm9yIGtlcm5lbCBpbnRlcm5hbCB1c2UKZGlmZiAtLWdpdCBh
L2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaCBiL2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaAppbmRl
eCA0ZmFlYmI0YzY4MjViLi5iMzIwODlhMTA0MjkxIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMv
b3ZlcmxheWZzLmgKKysrIGIvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oCkBAIC01MjksNyArNTI5
LDE0IEBAIHZvaWQgb3ZsX2Rpcl9tb2RpZmllZChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGJvb2wg
aW1wdXJpdHkpOwogdTY0IG92bF9pbm9kZV92ZXJzaW9uX2dldChzdHJ1Y3QgaW5vZGUgKmlub2Rl
KTsKIGJvb2wgb3ZsX2lzX3doaXRlb3V0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7CiBib29sIG92
bF9wYXRoX2lzX3doaXRlb3V0KHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGgg
KnBhdGgpOwotc3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW4oY29uc3Qgc3RydWN0IHBhdGggKnBh
dGgsIGludCBmbGFncyk7CitzdHJ1Y3QgZmlsZSAqb3ZsX3BhdGhfb3Blbl9yZWFsZmlsZShjb25z
dCBzdHJ1Y3QgZmlsZSAqdXNlcl9maWxlLAorCQkJCSAgICBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0
aCwgaW50IGZsYWdzKTsKKworc3RhdGljIGlubGluZSBzdHJ1Y3QgZmlsZSAqb3ZsX3BhdGhfb3Bl
bihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzKQoreworCXJldHVybiBvdmxfcGF0
aF9vcGVuX3JlYWxmaWxlKE5VTEwsIHBhdGgsIGZsYWdzKTsKK30KKwogaW50IG92bF9jb3B5X3Vw
X3N0YXJ0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgaW50IGZsYWdzKTsKIHZvaWQgb3ZsX2NvcHlf
dXBfZW5kKHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7CiBib29sIG92bF9hbHJlYWR5X2NvcGllZF91
cChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGludCBmbGFncyk7CmRpZmYgLS1naXQgYS9mcy9vdmVy
bGF5ZnMvcmVhZGRpci5jIGIvZnMvb3ZlcmxheWZzL3JlYWRkaXIuYwppbmRleCBiODYyMzA5ZWJh
NGQxLi41ZDIxYTMyOGZhZDQ2IDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvcmVhZGRpci5jCisr
KyBiL2ZzL292ZXJsYXlmcy9yZWFkZGlyLmMKQEAgLTk5NCw3ICs5OTQsOCBAQCBzdGF0aWMgc3Ry
dWN0IGZpbGUgKm92bF9kaXJfb3Blbl9yZWFsZmlsZShjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSwK
IAkJCQkJICBjb25zdCBzdHJ1Y3QgcGF0aCAqcmVhbHBhdGgpCiB7CiAJd2l0aF9vdmxfY3JlZHMo
ZmlsZV9pbm9kZShmaWxlKS0+aV9zYikKLQkJcmV0dXJuIG92bF9wYXRoX29wZW4ocmVhbHBhdGgs
IE9fUkRPTkxZIHwgKGZpbGUtPmZfZmxhZ3MgJiBPX0xBUkdFRklMRSkpOworCQlyZXR1cm4gb3Zs
X3BhdGhfb3Blbl9yZWFsZmlsZShmaWxlLCByZWFscGF0aCwKKwkJCQkJICAgICAgT19SRE9OTFkg
fCAoZmlsZS0+Zl9mbGFncyAmIE9fTEFSR0VGSUxFKSk7CiB9CiAKIC8qCmRpZmYgLS1naXQgYS9m
cy9vdmVybGF5ZnMvdXRpbC5jIGIvZnMvb3ZlcmxheWZzL3V0aWwuYwppbmRleCA0NzczNGVlYjk3
Yjc1Li4wNDEwM2E2NzQxYmEwIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvdXRpbC5jCisrKyBi
L2ZzL292ZXJsYXlmcy91dGlsLmMKQEAgLTY1NCw3ICs2NTQsOCBAQCBib29sIG92bF9wYXRoX2lz
X3doaXRlb3V0KHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpCiAJ
CW92bF9wYXRoX2NoZWNrX3h3aGl0ZW91dF94YXR0cihvZnMsIHBhdGgpOwogfQogCi1zdHJ1Y3Qg
ZmlsZSAqb3ZsX3BhdGhfb3Blbihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzKQor
c3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW5fcmVhbGZpbGUoY29uc3Qgc3RydWN0IGZpbGUgKnVz
ZXJfZmlsZSwKKwkJCQkgICAgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIGludCBmbGFncykKIHsK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9kZShwYXRoLT5kZW50cnkpOwogCXN0cnVjdCBt
bnRfaWRtYXAgKnJlYWxfaWRtYXAgPSBtbnRfaWRtYXAocGF0aC0+bW50KTsKQEAgLTY4Miw2ICs2
ODMsMTQgQEAgc3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW4oY29uc3Qgc3RydWN0IHBhdGggKnBh
dGgsIGludCBmbGFncykKIAlpZiAoaW5vZGVfb3duZXJfb3JfY2FwYWJsZShyZWFsX2lkbWFwLCBp
bm9kZSkpCiAJCWZsYWdzIHw9IE9fTk9BVElNRTsKIAorCS8qCisJICogRGlyZWN0b3J5IG9wZW5z
IHVzZSBkZW50cnlfb3BlbigpIGhlcmUsIG5vdCBiYWNraW5nX2ZpbGVfb3BlbigpLgorCSAqIElu
aGVyaXQgRk1PREVfTk9OT1RJRlkgZnJvbSBhIGZhbm90aWZ5IHBlcm1pc3Npb24gZmQgc28gYSBs
aXN0ZW5lcgorCSAqIHRoYXQgYWxzbyB3YXRjaGVzIHRoZSByZWFsIGZpbGVzeXN0ZW0gZG9lcyBu
b3QgZGVhZGxvY2suCisJICovCisJaWYgKHVzZXJfZmlsZSAmJiBGTU9ERV9GU05PVElGWV9OT05F
KHVzZXJfZmlsZS0+Zl9tb2RlKSkKKwkJcmV0dXJuIGRlbnRyeV9vcGVuX25vbm90aWZ5KHBhdGgs
IGZsYWdzLCBjdXJyZW50X2NyZWQoKSk7CisKIAlyZXR1cm4gZGVudHJ5X29wZW4ocGF0aCwgZmxh
Z3MsIGN1cnJlbnRfY3JlZCgpKTsKIH0KIAotLSAKMi41NS4wCgo=
--000000000000647aac065f11e915--
